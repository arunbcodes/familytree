import 'dart:convert';
import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';
import '../../models/person.dart';

part 'person_dao.g.dart';

/// Data Access Object for Person operations
@DriftAccessor(tables: [PersonsTable])
class PersonDao extends DatabaseAccessor<AppDatabase> with _$PersonDaoMixin {
  PersonDao(super.db);

  /// Get all persons for a tree
  Future<List<Person>> getPersonsForTree(String treeId) async {
    final rows = await (select(personsTable)
          ..where((p) => p.treeId.equals(treeId)))
        .get();
    return rows.map(_rowToPerson).toList();
  }

  /// Get a single person by ID
  Future<Person?> getPersonById(String id) async {
    final row = await (select(personsTable)..where((p) => p.id.equals(id)))
        .getSingleOrNull();
    return row != null ? _rowToPerson(row) : null;
  }

  /// Watch all persons for a tree (reactive)
  Stream<List<Person>> watchPersonsForTree(String treeId) {
    return (select(personsTable)..where((p) => p.treeId.equals(treeId)))
        .watch()
        .map((rows) => rows.map(_rowToPerson).toList());
  }

  /// Watch a single person by ID
  Stream<Person?> watchPersonById(String id) {
    return (select(personsTable)..where((p) => p.id.equals(id)))
        .watchSingleOrNull()
        .map((row) => row != null ? _rowToPerson(row) : null);
  }

  /// Insert or update a person
  Future<void> upsertPerson(Person person) async {
    await into(personsTable).insertOnConflictUpdate(_personToCompanion(person));
  }

  /// Insert multiple persons
  Future<void> insertPersons(List<Person> persons) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        personsTable,
        persons.map(_personToCompanion).toList(),
      );
    });
  }

  /// Delete a person
  Future<int> deletePerson(String id) async {
    return await (delete(personsTable)..where((p) => p.id.equals(id))).go();
  }

  /// Delete all persons for a tree
  Future<int> deletePersonsForTree(String treeId) async {
    return await (delete(personsTable)..where((p) => p.treeId.equals(treeId)))
        .go();
  }

  /// Delete all persons
  Future<int> deleteAll() async {
    return await delete(personsTable).go();
  }

  /// Get unsynced persons
  Future<List<Person>> getUnsyncedPersons() async {
    final rows = await (select(personsTable)
          ..where((p) => p.isSynced.equals(false)))
        .get();
    return rows.map(_rowToPerson).toList();
  }

  /// Mark a person as synced
  Future<void> markAsSynced(String id) async {
    await (update(personsTable)..where((p) => p.id.equals(id))).write(
      PersonsTableCompanion(
        isSynced: const Value(true),
        lastSyncedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Search persons by name
  Future<List<Person>> searchPersons(String treeId, String query) async {
    final lowerQuery = '%${query.toLowerCase()}%';
    final rows = await (select(personsTable)
          ..where((p) =>
              p.treeId.equals(treeId) &
              (p.firstName.lower().like(lowerQuery) |
                  p.lastName.lower().like(lowerQuery) |
                  p.nickname.lower().like(lowerQuery))))
        .get();
    return rows.map(_rowToPerson).toList();
  }

  /// Update custom position for a person
  Future<void> updateCustomPosition(String id, double? x, double? y) async {
    await (update(personsTable)..where((p) => p.id.equals(id))).write(
      PersonsTableCompanion(
        customX: Value(x),
        customY: Value(y),
        updatedAt: Value(DateTime.now()),
        isSynced: const Value(false),
      ),
    );
  }

  /// Clear all custom positions for a tree
  Future<void> clearCustomPositions(String treeId) async {
    await (update(personsTable)..where((p) => p.treeId.equals(treeId))).write(
      const PersonsTableCompanion(
        customX: Value(null),
        customY: Value(null),
      ),
    );
  }

  // Conversion helpers
  Person _rowToPerson(PersonsTableData row) {
    return Person(
      id: row.id,
      treeId: row.treeId,
      createdBy: row.createdBy,
      firstName: row.firstName,
      lastName: row.lastName,
      nickname: row.nickname,
      photoUrl: row.photoUrl,
      additionalPhotos: row.additionalPhotos != null
          ? List<String>.from(jsonDecode(row.additionalPhotos!))
          : [],
      birthDate: row.birthDate,
      deathDate: row.deathDate,
      isDeceased: row.isDeceased,
      bio: row.bio,
      location: row.location,
      contactEmail: row.contactEmail,
      contactPhone: row.contactPhone,
      claimedBy: row.claimedBy,
      claimedAt: row.claimedAt,
      isClaimable: row.isClaimable,
      proxyManagers: row.proxyManagers != null
          ? List<String>.from(jsonDecode(row.proxyManagers!))
          : [],
      proxyReason: row.proxyReason,
      isElderlyAssisted: row.isElderlyAssisted,
      visibility: PersonVisibility.values.firstWhere(
        (v) => v.name == row.visibility,
        orElse: () => PersonVisibility.treeMembers,
      ),
      customX: row.customX,
      customY: row.customY,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  PersonsTableCompanion _personToCompanion(Person person) {
    return PersonsTableCompanion(
      id: Value(person.id),
      treeId: Value(person.treeId),
      createdBy: Value(person.createdBy),
      firstName: Value(person.firstName),
      lastName: Value(person.lastName),
      nickname: Value(person.nickname),
      photoUrl: Value(person.photoUrl),
      additionalPhotos: Value(
        person.additionalPhotos.isNotEmpty
            ? jsonEncode(person.additionalPhotos)
            : null,
      ),
      birthDate: Value(person.birthDate),
      deathDate: Value(person.deathDate),
      isDeceased: Value(person.isDeceased),
      bio: Value(person.bio),
      location: Value(person.location),
      contactEmail: Value(person.contactEmail),
      contactPhone: Value(person.contactPhone),
      claimedBy: Value(person.claimedBy),
      claimedAt: Value(person.claimedAt),
      isClaimable: Value(person.isClaimable),
      proxyManagers: Value(
        person.proxyManagers.isNotEmpty
            ? jsonEncode(person.proxyManagers)
            : null,
      ),
      proxyReason: Value(person.proxyReason),
      isElderlyAssisted: Value(person.isElderlyAssisted),
      visibility: Value(person.visibility.name),
      customX: Value(person.customX),
      customY: Value(person.customY),
      createdAt: Value(person.createdAt),
      updatedAt: Value(person.updatedAt),
      isSynced: const Value(false),
    );
  }
}

