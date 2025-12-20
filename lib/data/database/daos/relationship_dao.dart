import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';
import '../../models/relationship.dart';

part 'relationship_dao.g.dart';

/// Data Access Object for Relationship operations
@DriftAccessor(tables: [RelationshipsTable])
class RelationshipDao extends DatabaseAccessor<AppDatabase>
    with _$RelationshipDaoMixin {
  RelationshipDao(super.db);

  /// Get all relationships for a tree
  Future<List<Relationship>> getRelationshipsForTree(String treeId) async {
    final rows = await (select(relationshipsTable)
          ..where((r) => r.treeId.equals(treeId)))
        .get();
    return rows.map(_rowToRelationship).toList();
  }

  /// Get relationships for a specific person
  Future<List<Relationship>> getRelationshipsForPerson(String personId) async {
    final rows = await (select(relationshipsTable)
          ..where((r) =>
              r.person1Id.equals(personId) | r.person2Id.equals(personId)))
        .get();
    return rows.map(_rowToRelationship).toList();
  }

  /// Watch all relationships for a tree (reactive)
  Stream<List<Relationship>> watchRelationshipsForTree(String treeId) {
    return (select(relationshipsTable)
          ..where((r) => r.treeId.equals(treeId)))
        .watch()
        .map((rows) => rows.map(_rowToRelationship).toList());
  }

  /// Watch relationships for a specific person
  Stream<List<Relationship>> watchRelationshipsForPerson(String personId) {
    return (select(relationshipsTable)
          ..where((r) =>
              r.person1Id.equals(personId) | r.person2Id.equals(personId)))
        .watch()
        .map((rows) => rows.map(_rowToRelationship).toList());
  }

  /// Get a single relationship by ID
  Future<Relationship?> getRelationshipById(String id) async {
    final row =
        await (select(relationshipsTable)..where((r) => r.id.equals(id)))
            .getSingleOrNull();
    return row != null ? _rowToRelationship(row) : null;
  }

  /// Insert or update a relationship
  Future<void> upsertRelationship(Relationship relationship) async {
    await into(relationshipsTable)
        .insertOnConflictUpdate(_relationshipToCompanion(relationship));
  }

  /// Insert multiple relationships
  Future<void> insertRelationships(List<Relationship> relationships) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        relationshipsTable,
        relationships.map(_relationshipToCompanion).toList(),
      );
    });
  }

  /// Delete a relationship
  Future<int> deleteRelationship(String id) async {
    return await (delete(relationshipsTable)..where((r) => r.id.equals(id)))
        .go();
  }

  /// Delete all relationships for a tree
  Future<int> deleteRelationshipsForTree(String treeId) async {
    return await (delete(relationshipsTable)
          ..where((r) => r.treeId.equals(treeId)))
        .go();
  }

  /// Delete all relationships involving a person
  Future<int> deleteRelationshipsForPerson(String personId) async {
    return await (delete(relationshipsTable)
          ..where((r) =>
              r.person1Id.equals(personId) | r.person2Id.equals(personId)))
        .go();
  }

  /// Get unsynced relationships
  Future<List<Relationship>> getUnsyncedRelationships() async {
    final rows = await (select(relationshipsTable)
          ..where((r) => r.isSynced.equals(false)))
        .get();
    return rows.map(_rowToRelationship).toList();
  }

  /// Mark a relationship as synced
  Future<void> markAsSynced(String id) async {
    await (update(relationshipsTable)..where((r) => r.id.equals(id))).write(
      const RelationshipsTableCompanion(
        isSynced: Value(true),
      ),
    );
  }

  /// Check if a relationship already exists between two persons
  Future<bool> relationshipExists(
    String person1Id,
    String person2Id,
    RelationshipType type,
  ) async {
    final rows = await (select(relationshipsTable)
          ..where((r) =>
              r.type.equals(type.name) &
              ((r.person1Id.equals(person1Id) &
                      r.person2Id.equals(person2Id)) |
                  (r.person1Id.equals(person2Id) &
                      r.person2Id.equals(person1Id)))))
        .get();
    return rows.isNotEmpty;
  }

  // Conversion helpers
  Relationship _rowToRelationship(RelationshipsTableData row) {
    return Relationship(
      id: row.id,
      treeId: row.treeId,
      person1Id: row.person1Id,
      person2Id: row.person2Id,
      type: RelationshipType.values.firstWhere(
        (t) => t.name == row.type,
        orElse: () => RelationshipType.parentChild,
      ),
      startDate: row.startDate,
      endDate: row.endDate,
      createdBy: row.createdBy,
      createdAt: row.createdAt,
    );
  }

  RelationshipsTableCompanion _relationshipToCompanion(
      Relationship relationship) {
    return RelationshipsTableCompanion(
      id: Value(relationship.id),
      treeId: Value(relationship.treeId),
      person1Id: Value(relationship.person1Id),
      person2Id: Value(relationship.person2Id),
      type: Value(relationship.type.name),
      startDate: Value(relationship.startDate),
      endDate: Value(relationship.endDate),
      createdBy: Value(relationship.createdBy),
      createdAt: Value(relationship.createdAt),
      isSynced: const Value(false),
    );
  }
}

