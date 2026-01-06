import 'package:drift/drift.dart';

/// Persons table - stores all family members
class PersonsTable extends Table {
  @override
  String get tableName => 'persons';

  TextColumn get id => text()();
  TextColumn get treeId => text().named('tree_id')();
  TextColumn get createdBy => text().named('created_by')();

  // Basic info
  TextColumn get firstName => text().named('first_name')();
  TextColumn get lastName => text().named('last_name')();
  TextColumn get nickname => text().nullable()();
  TextColumn get photoUrl => text().nullable().named('photo_url')();
  TextColumn get additionalPhotos =>
      text().nullable().named('additional_photos')(); // JSON array

  // Dates
  DateTimeColumn get birthDate => dateTime().nullable().named('birth_date')();
  DateTimeColumn get deathDate => dateTime().nullable().named('death_date')();
  BoolColumn get isDeceased =>
      boolean().withDefault(const Constant(false)).named('is_deceased')();

  // Extended info
  TextColumn get bio => text().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get contactEmail => text().nullable().named('contact_email')();
  TextColumn get contactPhone => text().nullable().named('contact_phone')();

  // Claim & Proxy
  TextColumn get claimedBy => text().nullable().named('claimed_by')();
  DateTimeColumn get claimedAt => dateTime().nullable().named('claimed_at')();
  BoolColumn get isClaimable =>
      boolean().withDefault(const Constant(true)).named('is_claimable')();
  TextColumn get proxyManagers =>
      text().nullable().named('proxy_managers')(); // JSON array
  TextColumn get proxyReason => text().nullable().named('proxy_reason')();
  BoolColumn get isElderlyAssisted =>
      boolean().withDefault(const Constant(false)).named('is_elderly_assisted')();

  // Privacy
  TextColumn get visibility =>
      text().withDefault(const Constant('treeMembers'))();

  // Custom layout position (set by user dragging)
  RealColumn get customX => real().nullable().named('custom_x')();
  RealColumn get customY => real().nullable().named('custom_y')();

  // Metadata
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  // Sync status
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false)).named('is_synced')();
  DateTimeColumn get lastSyncedAt =>
      dateTime().nullable().named('last_synced_at')();

  @override
  Set<Column> get primaryKey => {id};
}

/// Relationships table - stores connections between persons
class RelationshipsTable extends Table {
  @override
  String get tableName => 'relationships';

  TextColumn get id => text()();
  TextColumn get treeId => text().named('tree_id')();
  TextColumn get person1Id => text().named('person1_id')();
  TextColumn get person2Id => text().named('person2_id')();
  TextColumn get type => text()(); // parentChild, spouse, etc.
  DateTimeColumn get startDate => dateTime().nullable().named('start_date')();
  DateTimeColumn get endDate => dateTime().nullable().named('end_date')();
  TextColumn get createdBy => text().named('created_by')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();

  // Sync status
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false)).named('is_synced')();

  @override
  Set<Column> get primaryKey => {id};
}

/// Family trees table - stores tree metadata
class FamilyTreesTable extends Table {
  @override
  String get tableName => 'family_trees';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get ownerId => text().named('owner_id')();
  TextColumn get visibility =>
      text().withDefault(const Constant('private'))();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  // Sync status
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false)).named('is_synced')();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tree members table - stores user memberships in trees
class TreeMembersTable extends Table {
  @override
  String get tableName => 'tree_members';

  TextColumn get treeId => text().named('tree_id')();
  TextColumn get userId => text().named('user_id')();
  TextColumn get personId => text().nullable().named('person_id')();
  TextColumn get role => text().withDefault(const Constant('viewer'))();
  DateTimeColumn get joinedAt => dateTime().named('joined_at')();

  @override
  Set<Column> get primaryKey => {treeId, userId};
}

/// Sync queue table - stores pending changes to sync
class SyncQueueTable extends Table {
  @override
  String get tableName => 'sync_queue';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get tableName_ => text().named('table_name')();
  TextColumn get recordId => text().named('record_id')();
  TextColumn get operation => text()(); // insert, update, delete
  TextColumn get payload => text()(); // JSON of the change
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  IntColumn get retryCount =>
      integer().withDefault(const Constant(0)).named('retry_count')();
}

