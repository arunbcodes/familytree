import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/person.dart';
import '../../../data/models/relationship.dart';
import '../../../data/providers/database_provider.dart';
import '../../../data/repositories/tree_repository.dart';

/// Provider for the current tree ID
final currentTreeIdProvider = StateProvider<String?>((ref) => null);

/// Provider for the currently selected person ID
final selectedPersonIdProvider = StateProvider<String?>((ref) => null);

/// Provider for the center person ID (the person at the center of the view)
final centerPersonIdProvider = StateProvider<String?>((ref) => null);

/// Provider for node spacing (configurable via UI slider)
final nodeSpacingProvider = StateProvider<double>((ref) => 200.0);

/// Provider for tree data (persons and relationships)
final treeDataProvider =
    FutureProvider.autoDispose.family<TreeData?, String>((ref, treeId) async {
  final repository = ref.watch(treeRepositoryProvider);
  try {
    return await repository.getCompleteTree(treeId);
  } catch (e) {
    return null;
  }
});

/// Provider for watching tree data reactively
final treeDataStreamProvider =
    StreamProvider.autoDispose.family<TreeData, String>((ref, treeId) {
  final repository = ref.watch(treeRepositoryProvider);
  return repository.watchCompleteTree(treeId);
});

/// Provider for persons in the current tree
final personsProvider =
    FutureProvider.autoDispose.family<List<Person>, String>((ref, treeId) {
  final repository = ref.watch(treeRepositoryProvider);
  return repository.getPersons(treeId);
});

/// Provider for watching persons reactively
final personsStreamProvider =
    StreamProvider.autoDispose.family<List<Person>, String>((ref, treeId) {
  final repository = ref.watch(treeRepositoryProvider);
  return repository.watchPersons(treeId);
});

/// Provider for relationships in the current tree
final relationshipsProvider =
    FutureProvider.autoDispose.family<List<Relationship>, String>(
        (ref, treeId) {
  final repository = ref.watch(treeRepositoryProvider);
  return repository.getRelationships(treeId);
});

/// Provider for watching relationships reactively
final relationshipsStreamProvider =
    StreamProvider.autoDispose.family<List<Relationship>, String>(
        (ref, treeId) {
  final repository = ref.watch(treeRepositoryProvider);
  return repository.watchRelationships(treeId);
});

/// Provider for a single person
final personProvider =
    FutureProvider.autoDispose.family<Person?, String>((ref, personId) {
  final repository = ref.watch(treeRepositoryProvider);
  return repository.getPerson(personId);
});

/// Provider for watching a single person reactively
final personStreamProvider =
    StreamProvider.autoDispose.family<Person?, String>((ref, personId) {
  final repository = ref.watch(treeRepositoryProvider);
  return repository.watchPerson(personId);
});

/// Provider for relationships of a specific person
final personRelationshipsProvider =
    FutureProvider.autoDispose.family<List<Relationship>, String>(
        (ref, personId) {
  final repository = ref.watch(treeRepositoryProvider);
  return repository.getRelationshipsForPerson(personId);
});

/// Notifier for tree operations (mutations)
class TreeNotifier extends StateNotifier<AsyncValue<TreeData?>> {
  final TreeRepository _repository;
  final String treeId;

  TreeNotifier(this._repository, this.treeId)
      : super(const AsyncValue.loading()) {
    _loadTree();
  }

  Future<void> _loadTree() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getCompleteTree(treeId);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _loadTree();

  Future<Person> addPerson({
    required String firstName,
    required String lastName,
    required String createdBy,
    String? nickname,
    DateTime? birthDate,
    DateTime? deathDate,
    bool isDeceased = false,
    String? photoUrl,
    String? bio,
    String? location,
  }) async {
    final person = await _repository.addPerson(
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
    );
    await _loadTree(); // Refresh state
    return person;
  }

  Future<void> updatePerson(Person person) async {
    await _repository.updatePerson(person);
    await _loadTree();
  }

  Future<void> deletePerson(String personId) async {
    await _repository.deletePerson(personId);
    await _loadTree();
  }

  Future<Relationship> addRelationship({
    required String person1Id,
    required String person2Id,
    required RelationshipType type,
    required String createdBy,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final relationship = await _repository.addRelationship(
      treeId: treeId,
      person1Id: person1Id,
      person2Id: person2Id,
      type: type,
      createdBy: createdBy,
      startDate: startDate,
      endDate: endDate,
    );
    await _loadTree();
    return relationship;
  }

  Future<void> updateRelationship(Relationship relationship) async {
    await _repository.updateRelationship(relationship);
    await _loadTree();
  }

  Future<void> deleteRelationship(String relationshipId) async {
    await _repository.deleteRelationship(relationshipId);
    await _loadTree();
  }
}

/// Provider for tree notifier (for mutations)
final treeNotifierProvider = StateNotifierProvider.autoDispose
    .family<TreeNotifier, AsyncValue<TreeData?>, String>((ref, treeId) {
  final repository = ref.watch(treeRepositoryProvider);
  return TreeNotifier(repository, treeId);
});

/// Provider for searching persons
final personSearchProvider = FutureProvider.autoDispose
    .family<List<Person>, ({String treeId, String query})>((ref, params) {
  final repository = ref.watch(treeRepositoryProvider);
  return repository.searchPersons(params.treeId, params.query);
});

