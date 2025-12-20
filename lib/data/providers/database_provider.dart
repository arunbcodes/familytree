import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../repositories/tree_repository.dart';

/// Provider for the main database instance
/// This should be overridden in main.dart with the actual database
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Provider for the tree repository
final treeRepositoryProvider = Provider<TreeRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return TreeRepository(db);
});

