import 'package:uuid/uuid.dart';

import '../database/database.dart';
import '../models/family_tree.dart';
import '../models/person.dart';
import '../models/relationship.dart';

/// Repository for managing family tree data
/// Handles both local database and remote sync operations
class TreeRepository {
  final AppDatabase _db;
  final Uuid _uuid = const Uuid();

  TreeRepository(this._db);

  // ============ Family Tree Operations ============

  /// Create a new family tree with the creator as owner
  Future<FamilyTree> createTree({
    required String name,
    required String ownerId,
    String? description,
    TreeVisibility visibility = TreeVisibility.private,
  }) async {
    final now = DateTime.now();
    final tree = FamilyTree(
      id: _uuid.v4(),
      name: name,
      description: description,
      ownerId: ownerId,
      visibility: visibility,
      createdAt: now,
      updatedAt: now,
    );

    await _db.familyTreeDao.upsertTree(tree);

    // Add creator as owner
    final member = TreeMember(
      treeId: tree.id,
      userId: ownerId,
      role: TreeRole.owner,
      joinedAt: now,
    );
    await _db.familyTreeDao.addMember(member);

    return tree;
  }

  /// Get all trees for a user
  Future<List<FamilyTree>> getTreesForUser(String userId) {
    return _db.familyTreeDao.getTreesForUser(userId);
  }

  /// Watch all trees for a user (reactive stream)
  Stream<List<FamilyTree>> watchTreesForUser(String userId) {
    return _db.familyTreeDao.watchTreesForUser(userId);
  }

  /// Get a tree by ID
  Future<FamilyTree?> getTree(String treeId) {
    return _db.familyTreeDao.getTreeById(treeId);
  }

  /// Watch a tree by ID (reactive stream)
  Stream<FamilyTree?> watchTree(String treeId) {
    return _db.familyTreeDao.watchTreeById(treeId);
  }

  /// Update a tree
  Future<void> updateTree(FamilyTree tree) async {
    final updated = tree.copyWith(updatedAt: DateTime.now());
    await _db.familyTreeDao.upsertTree(updated);
  }

  /// Delete a tree and all its data
  Future<void> deleteTree(String treeId) async {
    // Delete all persons and relationships first
    await _db.personDao.deletePersonsForTree(treeId);
    await _db.relationshipDao.deleteRelationshipsForTree(treeId);
    await _db.familyTreeDao.deleteTree(treeId);
  }

  /// Get user's role in a tree
  Future<TreeRole?> getUserRole(String userId, String treeId) {
    return _db.familyTreeDao.getUserRoleInTree(userId, treeId);
  }

  /// Add a member to a tree
  Future<void> addMember({
    required String treeId,
    required String userId,
    required TreeRole role,
    String? personId,
  }) async {
    final member = TreeMember(
      treeId: treeId,
      userId: userId,
      personId: personId,
      role: role,
      joinedAt: DateTime.now(),
    );
    await _db.familyTreeDao.addMember(member);
  }

  /// Remove a member from a tree
  Future<void> removeMember(String userId, String treeId) {
    return _db.familyTreeDao.removeMember(userId, treeId);
  }

  /// Get all members of a tree
  Future<List<TreeMember>> getTreeMembers(String treeId) {
    return _db.familyTreeDao.getTreeMembers(treeId);
  }

  /// Update a member's role
  Future<void> updateMemberRole(
    String userId,
    String treeId,
    TreeRole newRole,
  ) {
    return _db.familyTreeDao.updateMemberRole(userId, treeId, newRole);
  }

  // ============ Person Operations ============

  /// Get all persons in a tree
  Future<List<Person>> getPersons(String treeId) {
    return _db.personDao.getPersonsForTree(treeId);
  }

  /// Watch all persons in a tree (reactive stream)
  Stream<List<Person>> watchPersons(String treeId) {
    return _db.personDao.watchPersonsForTree(treeId);
  }

  /// Get a person by ID
  Future<Person?> getPerson(String personId) {
    return _db.personDao.getPersonById(personId);
  }

  /// Watch a person by ID (reactive stream)
  Stream<Person?> watchPerson(String personId) {
    return _db.personDao.watchPersonById(personId);
  }

  /// Add a new person to a tree
  Future<Person> addPerson({
    required String treeId,
    required String createdBy,
    required String firstName,
    required String lastName,
    String? nickname,
    DateTime? birthDate,
    DateTime? deathDate,
    bool isDeceased = false,
    String? photoUrl,
    String? bio,
    String? location,
  }) async {
    final now = DateTime.now();
    final person = Person(
      id: _uuid.v4(),
      treeId: treeId,
      createdBy: createdBy,
      firstName: firstName,
      lastName: lastName,
      nickname: nickname,
      birthDate: birthDate,
      deathDate: deathDate,
      isDeceased: isDeceased,
      photoUrl: photoUrl,
      bio: bio,
      location: location,
      createdAt: now,
      updatedAt: now,
    );

    await _db.personDao.upsertPerson(person);
    return person;
  }

  /// Update a person
  Future<void> updatePerson(Person person) async {
    final updated = person.copyWith(updatedAt: DateTime.now());
    await _db.personDao.upsertPerson(updated);
  }

  /// Delete a person and their relationships
  Future<void> deletePerson(String personId) async {
    // Delete all relationships involving this person first
    await _db.relationshipDao.deleteRelationshipsForPerson(personId);
    await _db.personDao.deletePerson(personId);
  }

  /// Search persons by name
  Future<List<Person>> searchPersons(String treeId, String query) {
    return _db.personDao.searchPersons(treeId, query);
  }

  // ============ Relationship Operations ============

  /// Get all relationships in a tree
  Future<List<Relationship>> getRelationships(String treeId) {
    return _db.relationshipDao.getRelationshipsForTree(treeId);
  }

  /// Watch all relationships in a tree (reactive stream)
  Stream<List<Relationship>> watchRelationships(String treeId) {
    return _db.relationshipDao.watchRelationshipsForTree(treeId);
  }

  /// Get relationships for a specific person
  Future<List<Relationship>> getRelationshipsForPerson(String personId) {
    return _db.relationshipDao.getRelationshipsForPerson(personId);
  }

  /// Watch relationships for a specific person (reactive stream)
  Stream<List<Relationship>> watchRelationshipsForPerson(String personId) {
    return _db.relationshipDao.watchRelationshipsForPerson(personId);
  }

  /// Add a relationship between two persons
  Future<Relationship> addRelationship({
    required String treeId,
    required String person1Id,
    required String person2Id,
    required RelationshipType type,
    required String createdBy,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // Check if relationship already exists
    final exists = await _db.relationshipDao.relationshipExists(
      person1Id,
      person2Id,
      type,
    );
    if (exists) {
      throw Exception('Relationship already exists between these persons');
    }

    final relationship = Relationship(
      id: _uuid.v4(),
      treeId: treeId,
      person1Id: person1Id,
      person2Id: person2Id,
      type: type,
      startDate: startDate,
      endDate: endDate,
      createdBy: createdBy,
      createdAt: DateTime.now(),
    );

    await _db.relationshipDao.upsertRelationship(relationship);
    return relationship;
  }

  /// Update a relationship
  Future<void> updateRelationship(Relationship relationship) {
    return _db.relationshipDao.upsertRelationship(relationship);
  }

  /// Delete a relationship
  Future<void> deleteRelationship(String relationshipId) {
    return _db.relationshipDao.deleteRelationship(relationshipId);
  }

  // ============ Bulk Operations ============

  /// Get complete tree data (all persons and relationships)
  Future<TreeData> getCompleteTree(String treeId) async {
    final tree = await _db.familyTreeDao.getTreeById(treeId);
    if (tree == null) {
      throw Exception('Tree not found: $treeId');
    }

    final persons = await _db.personDao.getPersonsForTree(treeId);
    final relationships =
        await _db.relationshipDao.getRelationshipsForTree(treeId);

    return TreeData(
      tree: tree,
      persons: persons,
      relationships: relationships,
    );
  }

  /// Watch complete tree data (reactive stream)
  Stream<TreeData> watchCompleteTree(String treeId) async* {
    await for (final tree in _db.familyTreeDao.watchTreeById(treeId)) {
      if (tree == null) continue;

      final persons = await _db.personDao.getPersonsForTree(treeId);
      final relationships =
          await _db.relationshipDao.getRelationshipsForTree(treeId);

      yield TreeData(
        tree: tree,
        persons: persons,
        relationships: relationships,
      );
    }
  }

  /// Save complete tree data (for import/sync)
  Future<void> saveCompleteTree(TreeData data) async {
    await _db.familyTreeDao.upsertTree(data.tree);
    await _db.personDao.insertPersons(data.persons);
    await _db.relationshipDao.insertRelationships(data.relationships);
  }
}

/// Container for complete tree data
class TreeData {
  final FamilyTree tree;
  final List<Person> persons;
  final List<Relationship> relationships;

  const TreeData({
    required this.tree,
    required this.persons,
    required this.relationships,
  });

  /// Find a person by ID
  Person? findPerson(String id) {
    try {
      return persons.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get relationships for a person
  List<Relationship> getRelationshipsFor(String personId) {
    return relationships
        .where((r) => r.person1Id == personId || r.person2Id == personId)
        .toList();
  }

  /// Get connected person IDs for a person
  Set<String> getConnectedPersonIds(String personId) {
    final connected = <String>{};
    for (final rel in getRelationshipsFor(personId)) {
      if (rel.person1Id == personId) {
        connected.add(rel.person2Id);
      } else {
        connected.add(rel.person1Id);
      }
    }
    return connected;
  }
}

