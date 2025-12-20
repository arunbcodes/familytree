import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../database/database.dart';
import '../models/person.dart';
import '../models/relationship.dart';
import 'supabase_service.dart';

/// Service for syncing local database with Supabase
class SyncService {
  final AppDatabase _db;
  final SupabaseClient? _supabase;

  final List<RealtimeChannel> _subscriptions = [];
  bool _isSyncing = false;

  SyncService(this._db) : _supabase = SupabaseService.client;

  /// Check if sync is available
  bool get isAvailable => SupabaseService.isAvailable;

  /// Initialize sync subscriptions for a tree
  Future<void> subscribeToTree(String treeId) async {
    if (!isAvailable) return;

    // Subscribe to persons changes
    final personsChannel = _supabase?.subscribeToPersons(treeId, (payload) {
      _handlePersonChange(payload);
    });
    if (personsChannel != null) {
      _subscriptions.add(personsChannel);
    }

    // Subscribe to relationships changes
    final relationshipsChannel = _supabase?.subscribeToRelationships(treeId, (payload) {
      _handleRelationshipChange(payload);
    });
    if (relationshipsChannel != null) {
      _subscriptions.add(relationshipsChannel);
    }
  }

  /// Unsubscribe from all realtime channels
  Future<void> unsubscribeAll() async {
    for (final channel in _subscriptions) {
      await _supabase?.removeChannel(channel);
    }
    _subscriptions.clear();
  }

  /// Handle person change from realtime subscription
  void _handlePersonChange(PostgresChangePayload payload) async {
    switch (payload.eventType) {
      case PostgresChangeEvent.insert:
      case PostgresChangeEvent.update:
        final person = Person.fromJson(payload.newRecord);
        await _db.personDao.upsertPerson(person);
        break;
      case PostgresChangeEvent.delete:
        final id = payload.oldRecord['id'] as String?;
        if (id != null) {
          await _db.personDao.deletePerson(id);
        }
        break;
      default:
        break;
    }
  }

  /// Handle relationship change from realtime subscription
  void _handleRelationshipChange(PostgresChangePayload payload) async {
    switch (payload.eventType) {
      case PostgresChangeEvent.insert:
      case PostgresChangeEvent.update:
        final relationship = Relationship.fromJson(payload.newRecord);
        await _db.relationshipDao.upsertRelationship(relationship);
        break;
      case PostgresChangeEvent.delete:
        final id = payload.oldRecord['id'] as String?;
        if (id != null) {
          await _db.relationshipDao.deleteRelationship(id);
        }
        break;
      default:
        break;
    }
  }

  /// Sync a tree from remote to local
  Future<void> pullTree(String treeId) async {
    if (!isAvailable || _isSyncing || _supabase == null) return;

    _isSyncing = true;
    try {
      // Fetch remote data
      final persons = await _supabase.getPersons(treeId);
      final relationships = await _supabase.getRelationships(treeId);

      // Upsert to local database
      for (final person in persons) {
        await _db.personDao.upsertPerson(person);
      }
      for (final relationship in relationships) {
        await _db.relationshipDao.upsertRelationship(relationship);
      }
    } finally {
      _isSyncing = false;
    }
  }

  /// Sync a tree from local to remote
  Future<void> pushTree(String treeId) async {
    if (!isAvailable || _isSyncing || _supabase == null) return;

    _isSyncing = true;
    try {
      // Get local data
      final persons = await _db.personDao.getPersonsForTree(treeId);
      final relationships = await _db.relationshipDao.getRelationshipsForTree(treeId);

      // Push to remote
      for (final person in persons) {
        try {
          await _supabase.createPerson(person);
        } catch (_) {
          // Person might already exist, try update
          await _supabase.updatePerson(person);
        }
      }
      for (final relationship in relationships) {
        try {
          await _supabase.createRelationship(relationship);
        } catch (_) {
          // Relationship might already exist, try update
          await _supabase.updateRelationship(relationship);
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  /// Full two-way sync
  Future<void> syncTree(String treeId) async {
    if (!isAvailable || _isSyncing || _supabase == null) return;

    _isSyncing = true;
    try {
      // Get local and remote data
      final localPersons = await _db.personDao.getPersonsForTree(treeId);
      final remotePersons = await _supabase.getPersons(treeId);

      final localRelationships = await _db.relationshipDao.getRelationshipsForTree(treeId);
      final remoteRelationships = await _supabase.getRelationships(treeId);

      // Create maps for easy lookup
      final localPersonMap = {for (var p in localPersons) p.id: p};
      final remotePersonMap = {for (var p in remotePersons) p.id: p};

      final localRelMap = {for (var r in localRelationships) r.id: r};
      final remoteRelMap = {for (var r in remoteRelationships) r.id: r};

      // Merge persons - newer wins
      for (final remote in remotePersons) {
        final local = localPersonMap[remote.id];
        if (local == null || remote.updatedAt.isAfter(local.updatedAt)) {
          await _db.personDao.upsertPerson(remote);
        } else if (local.updatedAt.isAfter(remote.updatedAt)) {
          await _supabase.updatePerson(local);
        }
      }

      // Push local-only persons
      for (final local in localPersons) {
        if (!remotePersonMap.containsKey(local.id)) {
          await _supabase.createPerson(local);
        }
      }

      // Merge relationships - newer wins
      for (final remote in remoteRelationships) {
        final local = localRelMap[remote.id];
        if (local == null || remote.createdAt.isAfter(local.createdAt)) {
          await _db.relationshipDao.upsertRelationship(remote);
        }
      }

      // Push local-only relationships
      for (final local in localRelationships) {
        if (!remoteRelMap.containsKey(local.id)) {
          await _supabase.createRelationship(local);
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  /// Sync all trees for current user
  Future<void> syncAllTrees() async {
    if (!isAvailable || _supabase == null) return;

    final trees = await _supabase.getTrees();
    for (final tree in trees) {
      // Upsert tree to local database
      await _db.familyTreeDao.upsertTree(tree);
      // Sync tree data
      await syncTree(tree.id);
    }
  }
}

