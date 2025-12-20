import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/graph_layout.dart';
import '../../../data/models/person.dart';
import '../../../data/models/relationship.dart';
import '../../../data/providers/database_provider.dart';
import '../../../data/repositories/tree_repository.dart';
import '../providers/tree_provider.dart';
import '../widgets/tree_canvas.dart';

/// Main screen displaying the family tree visualization
class TreeScreen extends ConsumerStatefulWidget {
  const TreeScreen({super.key});

  @override
  ConsumerState<TreeScreen> createState() => _TreeScreenState();
}

class _TreeScreenState extends ConsumerState<TreeScreen> {
  LayoutType _layoutType = LayoutType.radial;
  String? _treeId;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeTree();
  }

  Future<void> _initializeTree() async {
    final repository = ref.read(treeRepositoryProvider);

    // Check if user has any trees
    // For demo, we'll use a hardcoded user ID and create a demo tree if none exists
    const demoUserId = 'demo-user-id';

    try {
      final trees = await repository.getTreesForUser(demoUserId);

      if (trees.isEmpty) {
        // Create a demo tree with sample data
        final tree = await _createDemoTree(repository, demoUserId);
        _treeId = tree.tree.id;
      } else {
        _treeId = trees.first.id;
      }

      if (mounted) {
        setState(() => _isInitialized = true);
      }
    } catch (e) {
      // If database isn't ready yet, show demo data
      debugPrint('Error initializing tree: $e');
      if (mounted) {
        setState(() => _isInitialized = true);
      }
    }
  }

  Future<TreeData> _createDemoTree(
      TreeRepository repository, String userId) async {
    final tree = await repository.createTree(
      name: 'My Family Tree',
      ownerId: userId,
      description: 'My family history',
    );

    // Create demo persons
    final self = await repository.addPerson(
      treeId: tree.id,
      createdBy: userId,
      firstName: 'You',
      lastName: 'Demo',
      birthDate: DateTime(1990, 5, 15),
    );

    final mother = await repository.addPerson(
      treeId: tree.id,
      createdBy: userId,
      firstName: 'Mom',
      lastName: 'Demo',
      birthDate: DateTime(1965, 3, 20),
    );

    final father = await repository.addPerson(
      treeId: tree.id,
      createdBy: userId,
      firstName: 'Dad',
      lastName: 'Demo',
      birthDate: DateTime(1963, 8, 10),
    );

    final sibling = await repository.addPerson(
      treeId: tree.id,
      createdBy: userId,
      firstName: 'Brother',
      lastName: 'Demo',
      birthDate: DateTime(1988, 1, 25),
    );

    final spouse = await repository.addPerson(
      treeId: tree.id,
      createdBy: userId,
      firstName: 'Spouse',
      lastName: 'Demo',
      birthDate: DateTime(1991, 11, 5),
    );

    final grandmaM = await repository.addPerson(
      treeId: tree.id,
      createdBy: userId,
      firstName: 'Grandma',
      lastName: 'Maternal',
      birthDate: DateTime(1940, 6, 1),
      isDeceased: true,
      deathDate: DateTime(2020, 2, 14),
    );

    final grandpaM = await repository.addPerson(
      treeId: tree.id,
      createdBy: userId,
      firstName: 'Grandpa',
      lastName: 'Maternal',
      birthDate: DateTime(1938, 9, 22),
      isDeceased: true,
      deathDate: DateTime(2018, 7, 30),
    );

    final child = await repository.addPerson(
      treeId: tree.id,
      createdBy: userId,
      firstName: 'Child',
      lastName: 'Demo',
      birthDate: DateTime(2018, 4, 10),
    );

    // Create relationships
    await repository.addRelationship(
      treeId: tree.id,
      person1Id: mother.id,
      person2Id: self.id,
      type: RelationshipType.parentChild,
      createdBy: userId,
    );

    await repository.addRelationship(
      treeId: tree.id,
      person1Id: father.id,
      person2Id: self.id,
      type: RelationshipType.parentChild,
      createdBy: userId,
    );

    await repository.addRelationship(
      treeId: tree.id,
      person1Id: mother.id,
      person2Id: father.id,
      type: RelationshipType.spouse,
      createdBy: userId,
      startDate: DateTime(1985, 6, 15),
    );

    await repository.addRelationship(
      treeId: tree.id,
      person1Id: self.id,
      person2Id: sibling.id,
      type: RelationshipType.sibling,
      createdBy: userId,
    );

    await repository.addRelationship(
      treeId: tree.id,
      person1Id: self.id,
      person2Id: spouse.id,
      type: RelationshipType.spouse,
      createdBy: userId,
      startDate: DateTime(2015, 9, 20),
    );

    await repository.addRelationship(
      treeId: tree.id,
      person1Id: grandmaM.id,
      person2Id: mother.id,
      type: RelationshipType.parentChild,
      createdBy: userId,
    );

    await repository.addRelationship(
      treeId: tree.id,
      person1Id: grandpaM.id,
      person2Id: mother.id,
      type: RelationshipType.parentChild,
      createdBy: userId,
    );

    await repository.addRelationship(
      treeId: tree.id,
      person1Id: grandmaM.id,
      person2Id: grandpaM.id,
      type: RelationshipType.spouse,
      createdBy: userId,
    );

    await repository.addRelationship(
      treeId: tree.id,
      person1Id: self.id,
      person2Id: child.id,
      type: RelationshipType.parentChild,
      createdBy: userId,
    );

    // Link user to self person and set as center
    ref.read(centerPersonIdProvider.notifier).state = self.id;

    return repository.getCompleteTree(tree.id);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // If no tree ID, show loading or create tree UI
    if (_treeId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Family Tree')),
        body: const Center(
          child: Text('No family tree found. Create one to get started!'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // TODO: Show create tree dialog
          },
          label: const Text('Create Tree'),
          icon: const Icon(Icons.add),
        ),
      );
    }

    // Watch tree data
    final treeDataAsync = ref.watch(treeNotifierProvider(_treeId!));
    final selectedPersonId = ref.watch(selectedPersonIdProvider);
    final centerPersonId = ref.watch(centerPersonIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Family Tree'),
        actions: [
          // Layout type toggle
          PopupMenuButton<LayoutType>(
            icon: const Icon(Icons.auto_graph),
            tooltip: 'Change layout',
            onSelected: (layout) {
              HapticFeedback.selectionClick();
              setState(() => _layoutType = layout);
            },
            itemBuilder: (context) => [
              _buildLayoutMenuItem(LayoutType.radial, Icons.radio_button_checked, 'Radial'),
              _buildLayoutMenuItem(LayoutType.sunburst, Icons.wb_sunny, 'Sunburst'),
              _buildLayoutMenuItem(LayoutType.tree, Icons.account_tree, 'Tree'),
              _buildLayoutMenuItem(LayoutType.forceDirected, Icons.hub, 'Force-Directed'),
            ],
          ),
          // Settings
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: treeDataAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading tree: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(treeNotifierProvider(_treeId!)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (treeData) {
          if (treeData == null || treeData.persons.isEmpty) {
            return _buildEmptyState();
          }

          // Determine center person
          final center = centerPersonId ?? treeData.persons.first.id;

          return TreeCanvas(
            persons: treeData.persons,
            relationships: treeData.relationships,
            centerPersonId: center,
            layoutType: _layoutType,
            onPersonTap: (personId) {
              HapticFeedback.selectionClick();
              ref.read(selectedPersonIdProvider.notifier).state =
                  selectedPersonId == personId ? null : personId;
            },
            onPersonDoubleTap: (personId) {
              // Double-tap to make this person the new center
              HapticFeedback.mediumImpact();
              ref.read(centerPersonIdProvider.notifier).state = personId;
              // Show a brief feedback
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Centered on ${treeData.findPerson(personId)?.firstName ?? 'person'}'),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            onPersonLongPress: (personId) {
              HapticFeedback.mediumImpact();
              context.push('/person/$personId');
            },
            onExpandPerson: (personId) {
              _showAddRelativeSheet(personId, treeData.persons);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPersonDialog,
        tooltip: 'Add family member',
        child: const Icon(Icons.person_add),
      ),
    );
  }

  PopupMenuItem<LayoutType> _buildLayoutMenuItem(
    LayoutType type,
    IconData icon,
    String label,
  ) {
    return PopupMenuItem(
      value: type,
      child: Row(
        children: [
          Icon(
            icon,
            color: _layoutType == type ? AppColors.primary : null,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.family_restroom,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Your family tree is empty',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Add yourself to get started!',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _showAddPersonDialog,
            icon: const Icon(Icons.person_add),
            label: const Text('Add Yourself'),
          ),
        ],
      ),
    );
  }

  void _showAddPersonDialog() {
    // Get the center person to relate to (if any)
    final centerPersonId = ref.read(centerPersonIdProvider);

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Family Member',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Add Parent'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddPersonForm(
                    RelationshipType.parentChild,
                    isParent: true,
                    relatedToPersonId: centerPersonId,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Add Sibling'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddPersonForm(
                    RelationshipType.sibling,
                    relatedToPersonId: centerPersonId,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Add Spouse/Partner'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddPersonForm(
                    RelationshipType.spouse,
                    relatedToPersonId: centerPersonId,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.child_care),
                title: const Text('Add Child'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddPersonForm(
                    RelationshipType.parentChild,
                    isParent: false,
                    relatedToPersonId: centerPersonId,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddPersonForm(
    RelationshipType type, {
    bool isParent = false,
    String? relatedToPersonId,
  }) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();

    // Determine the title based on relationship type
    String title;
    switch (type) {
      case RelationshipType.parentChild:
        title = isParent ? 'Add Parent' : 'Add Child';
        break;
      case RelationshipType.spouse:
        title = 'Add Spouse/Partner';
        break;
      case RelationshipType.sibling:
        title = 'Add Sibling';
        break;
      default:
        title = 'Add Family Member';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
              textCapitalization: TextCapitalization.words,
              autofocus: true,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              if (firstNameController.text.isNotEmpty && _treeId != null) {
                final notifier = ref.read(treeNotifierProvider(_treeId!).notifier);

                // Create the new person
                final newPerson = await notifier.addPerson(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  createdBy: 'demo-user-id',
                );

                // Create relationship if we have a related person
                if (relatedToPersonId != null) {
                  // Determine person1 and person2 based on relationship direction
                  // For parentChild: person1 is parent, person2 is child
                  String person1Id;
                  String person2Id;

                  if (type == RelationshipType.parentChild) {
                    if (isParent) {
                      // New person is the parent of the related person
                      person1Id = newPerson.id;
                      person2Id = relatedToPersonId;
                    } else {
                      // Related person is the parent of the new person (child)
                      person1Id = relatedToPersonId;
                      person2Id = newPerson.id;
                    }
                  } else {
                    // For symmetric relationships (spouse, sibling), order doesn't matter
                    person1Id = relatedToPersonId;
                    person2Id = newPerson.id;
                  }

                  await notifier.addRelationship(
                    person1Id: person1Id,
                    person2Id: person2Id,
                    type: type,
                    createdBy: 'demo-user-id',
                  );
                }

                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddRelativeSheet(String personId, List<Person> persons) {
    final person = persons.firstWhere(
      (p) => p.id == personId,
      orElse: () => persons.first,
    );

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add relative for ${person.firstName}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Add Parent'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddPersonForm(
                    RelationshipType.parentChild,
                    isParent: true,
                    relatedToPersonId: personId,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Add Sibling'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddPersonForm(
                    RelationshipType.sibling,
                    relatedToPersonId: personId,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Add Spouse/Partner'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddPersonForm(
                    RelationshipType.spouse,
                    relatedToPersonId: personId,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.child_care),
                title: const Text('Add Child'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddPersonForm(
                    RelationshipType.parentChild,
                    isParent: false,
                    relatedToPersonId: personId,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
