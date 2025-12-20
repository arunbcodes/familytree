import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/person.dart';
import '../../../data/models/relationship.dart';
import '../../tree_view/providers/tree_provider.dart';
import '../../tree_view/widgets/hexagon_avatar.dart';

/// Screen showing detailed information about a person
class PersonDetailScreen extends ConsumerWidget {
  final String personId;

  const PersonDetailScreen({
    super.key,
    required this.personId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personAsync = ref.watch(personStreamProvider(personId));
    final relationshipsAsync = ref.watch(personRelationshipsProvider(personId));

    return personAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading person: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(personStreamProvider(personId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (person) {
        if (person == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Person not found'),
            ),
          );
        }

        return _PersonDetailView(
          person: person,
          relationshipsAsync: relationshipsAsync,
        );
      },
    );
  }
}

class _PersonDetailView extends ConsumerWidget {
  final Person person;
  final AsyncValue<List<Relationship>> relationshipsAsync;

  const _PersonDetailView({
    required this.person,
    required this.relationshipsAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header with hexagon avatar
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // Hexagon avatar
                      HexagonAvatar(
                        imageUrl: person.photoUrl,
                        initials: person.initials,
                        size: 120,
                        isDeceased: person.isDeceased,
                        isElderlyAssisted: person.isElderlyAssisted,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        person.fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getDateRangeText(),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showEditPersonSheet(context, ref);
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  _showOptionsMenu(context, ref);
                },
              ),
            ],
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(AppSizes.spacingMd),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Photo gallery section
                _buildSection(
                  context,
                  title: 'Photos',
                  trailing: TextButton(
                    onPressed: () {
                      // TODO: Add photo picker
                    },
                    child: const Text('Add'),
                  ),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: person.additionalPhotos.length + 1,
                      itemBuilder: (context, index) {
                        if (index == person.additionalPhotos.length) {
                          return Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.add_photo_alternate,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          );
                        }
                        return Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(person.additionalPhotos[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spacingLg),

                // Basic info section
                _buildSection(
                  context,
                  title: 'Basic Information',
                  child: Column(
                    children: [
                      if (person.birthDate != null)
                        _buildInfoRow(
                          Icons.cake,
                          'Birth Date',
                          _formatDate(person.birthDate!),
                        ),
                      if (person.location != null)
                        _buildInfoRow(
                          Icons.location_on,
                          'Location',
                          person.location!,
                        ),
                      if (person.contactEmail != null)
                        _buildInfoRow(
                          Icons.email,
                          'Email',
                          person.contactEmail!,
                        ),
                      if (person.contactPhone != null)
                        _buildInfoRow(
                          Icons.phone,
                          'Phone',
                          person.contactPhone!,
                        ),
                      if (person.age != null)
                        _buildInfoRow(
                          Icons.person,
                          'Age',
                          '${person.age} years old',
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.spacingLg),

                // Bio section
                if (person.bio != null && person.bio!.isNotEmpty) ...[
                  _buildSection(
                    context,
                    title: 'Bio',
                    child: Text(
                      person.bio!,
                      style: const TextStyle(height: 1.5),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingLg),
                ],

                // Relationships section
                _buildSection(
                  context,
                  title: 'Family Connections',
                  child: relationshipsAsync.when(
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (e, s) => Text('Error loading relationships: $e'),
                    data: (relationships) {
                      if (relationships.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('No family connections yet'),
                        );
                      }

                      return Column(
                        children: relationships.map((rel) {
                          final otherPersonId = rel.getOtherPersonId(person.id);
                          return _RelationshipTile(
                            relationship: rel,
                            currentPersonId: person.id,
                            otherPersonId: otherPersonId,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.spacingXl),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getDateRangeText() {
    if (person.birthDate == null) return 'Unknown';

    final birthYear = person.birthDate!.year;
    if (person.isDeceased && person.deathDate != null) {
      return '$birthYear - ${person.deathDate!.year}';
    } else if (person.isDeceased) {
      return '$birthYear - ?';
    }
    return '$birthYear - Present';
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget child,
    Widget? trailing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (trailing != null) trailing,
          ],
        ),
        const SizedBox(height: AppSizes.spacingSm),
        child,
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingSm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: AppSizes.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditPersonSheet(BuildContext context, WidgetRef ref) {
    // TODO: Implement edit person form
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit person coming soon!')),
    );
  }

  void _showOptionsMenu(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Profile'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Add Relationship'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Report Issue'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Remove from Tree',
                  style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Person'),
        content: Text(
          'Are you sure you want to remove ${person.fullName} from the family tree? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // TODO: Delete person via notifier
              if (context.mounted) {
                context.pop();
              }
            },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

/// Tile showing a relationship with another person
class _RelationshipTile extends ConsumerWidget {
  final Relationship relationship;
  final String currentPersonId;
  final String otherPersonId;

  const _RelationshipTile({
    required this.relationship,
    required this.currentPersonId,
    required this.otherPersonId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otherPersonAsync = ref.watch(personProvider(otherPersonId));

    return otherPersonAsync.when(
      loading: () => const ListTile(
        leading: CircleAvatar(child: CircularProgressIndicator(strokeWidth: 2)),
        title: Text('Loading...'),
      ),
      error: (e, s) => ListTile(
        leading: const CircleAvatar(child: Icon(Icons.error)),
        title: Text('Error: $e'),
      ),
      data: (otherPerson) {
        if (otherPerson == null) {
          return const SizedBox.shrink();
        }

        final color = relationship.type.color;
        final label = relationship.getLabelFor(currentPersonId);

        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.2),
            child: Text(
              otherPerson.initials,
              style: TextStyle(color: color),
            ),
          ),
          title: Text(otherPerson.fullName),
          subtitle: Text(label),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.push('/person/${otherPerson.id}');
          },
        );
      },
    );
  }
}
