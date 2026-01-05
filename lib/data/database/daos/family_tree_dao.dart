import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';
import '../../models/family_tree.dart';

part 'family_tree_dao.g.dart';

/// Data Access Object for FamilyTree operations
@DriftAccessor(tables: [FamilyTreesTable, TreeMembersTable])
class FamilyTreeDao extends DatabaseAccessor<AppDatabase>
    with _$FamilyTreeDaoMixin {
  FamilyTreeDao(super.db);

  /// Get all trees for a user
  Future<List<FamilyTree>> getTreesForUser(String userId) async {
    final memberRows = await (select(treeMembersTable)
          ..where((m) => m.userId.equals(userId)))
        .get();
    
    if (memberRows.isEmpty) return [];

    final treeIds = memberRows.map((m) => m.treeId).toList();
    final treeRows = await (select(familyTreesTable)
          ..where((t) => t.id.isIn(treeIds)))
        .get();

    return treeRows.map(_rowToFamilyTree).toList();
  }

  /// Get a single tree by ID
  Future<FamilyTree?> getTreeById(String id) async {
    final row =
        await (select(familyTreesTable)..where((t) => t.id.equals(id)))
            .getSingleOrNull();
    return row != null ? _rowToFamilyTree(row) : null;
  }

  /// Watch all trees for a user (reactive)
  Stream<List<FamilyTree>> watchTreesForUser(String userId) {
    final memberQuery = select(treeMembersTable)
      ..where((m) => m.userId.equals(userId));

    return memberQuery.watch().asyncMap((members) async {
      if (members.isEmpty) return <FamilyTree>[];
      
      final treeIds = members.map((m) => m.treeId).toList();
      final trees = await (select(familyTreesTable)
            ..where((t) => t.id.isIn(treeIds)))
          .get();
      
      return trees.map(_rowToFamilyTree).toList();
    });
  }

  /// Watch a single tree by ID
  Stream<FamilyTree?> watchTreeById(String id) {
    return (select(familyTreesTable)..where((t) => t.id.equals(id)))
        .watchSingleOrNull()
        .map((row) => row != null ? _rowToFamilyTree(row) : null);
  }

  /// Insert or update a tree
  Future<void> upsertTree(FamilyTree tree) async {
    await into(familyTreesTable)
        .insertOnConflictUpdate(_treeToCompanion(tree));
  }

  /// Delete a tree
  Future<void> deleteTree(String id) async {
    await (delete(familyTreesTable)..where((t) => t.id.equals(id))).go();
    await (delete(treeMembersTable)..where((m) => m.treeId.equals(id))).go();
  }

  /// Delete all trees and members
  Future<void> deleteAll() async {
    await delete(treeMembersTable).go();
    await delete(familyTreesTable).go();
  }

  /// Get user's role in a tree
  Future<TreeRole?> getUserRoleInTree(String userId, String treeId) async {
    final row = await (select(treeMembersTable)
          ..where(
              (m) => m.userId.equals(userId) & m.treeId.equals(treeId)))
        .getSingleOrNull();

    if (row == null) return null;
    return TreeRole.values.firstWhere(
      (r) => r.name == row.role,
      orElse: () => TreeRole.viewer,
    );
  }

  /// Add a member to a tree
  Future<void> addMember(TreeMember member) async {
    await into(treeMembersTable).insertOnConflictUpdate(
      TreeMembersTableCompanion(
        treeId: Value(member.treeId),
        userId: Value(member.userId),
        personId: Value(member.personId),
        role: Value(member.role.name),
        joinedAt: Value(member.joinedAt),
      ),
    );
  }

  /// Remove a member from a tree
  Future<int> removeMember(String userId, String treeId) async {
    return await (delete(treeMembersTable)
          ..where((m) => m.userId.equals(userId) & m.treeId.equals(treeId)))
        .go();
  }

  /// Get all members of a tree
  Future<List<TreeMember>> getTreeMembers(String treeId) async {
    final rows = await (select(treeMembersTable)
          ..where((m) => m.treeId.equals(treeId)))
        .get();
    return rows.map(_rowToTreeMember).toList();
  }

  /// Update member role
  Future<void> updateMemberRole(
      String userId, String treeId, TreeRole newRole) async {
    await (update(treeMembersTable)
          ..where((m) => m.userId.equals(userId) & m.treeId.equals(treeId)))
        .write(TreeMembersTableCompanion(role: Value(newRole.name)));
  }

  /// Link a member to a person in the tree
  Future<void> linkMemberToPerson(
      String userId, String treeId, String personId) async {
    await (update(treeMembersTable)
          ..where((m) => m.userId.equals(userId) & m.treeId.equals(treeId)))
        .write(TreeMembersTableCompanion(personId: Value(personId)));
  }

  // Conversion helpers
  FamilyTree _rowToFamilyTree(FamilyTreesTableData row) {
    return FamilyTree(
      id: row.id,
      name: row.name,
      description: row.description,
      ownerId: row.ownerId,
      visibility: TreeVisibility.values.firstWhere(
        (v) => v.name == row.visibility,
        orElse: () => TreeVisibility.private,
      ),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  FamilyTreesTableCompanion _treeToCompanion(FamilyTree tree) {
    return FamilyTreesTableCompanion(
      id: Value(tree.id),
      name: Value(tree.name),
      description: Value(tree.description),
      ownerId: Value(tree.ownerId),
      visibility: Value(tree.visibility.name),
      createdAt: Value(tree.createdAt),
      updatedAt: Value(tree.updatedAt),
      isSynced: const Value(false),
    );
  }

  TreeMember _rowToTreeMember(TreeMembersTableData row) {
    return TreeMember(
      treeId: row.treeId,
      userId: row.userId,
      personId: row.personId,
      role: TreeRole.values.firstWhere(
        (r) => r.name == row.role,
        orElse: () => TreeRole.viewer,
      ),
      joinedAt: row.joinedAt,
    );
  }
}

