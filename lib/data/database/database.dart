import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';
import 'daos/person_dao.dart';
import 'daos/relationship_dao.dart';
import 'daos/family_tree_dao.dart';

part 'database.g.dart';

/// The main Drift database for the Family Tree app
@DriftDatabase(
  tables: [
    PersonsTable,
    RelationshipsTable,
    FamilyTreesTable,
    TreeMembersTable,
    SyncQueueTable,
  ],
  daos: [
    PersonDao,
    RelationshipDao,
    FamilyTreeDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// For testing with in-memory database
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Migration from version 1 to 2: add custom position columns
        if (from < 2) {
          await m.addColumn(personsTable, personsTable.customX);
          await m.addColumn(personsTable, personsTable.customY);
        }
      },
    );
  }
}

/// Opens a connection to the SQLite database
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'familytree.db'));
    return NativeDatabase.createInBackground(file);
  });
}

