import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/person.dart';
import '../providers/tree_provider.dart';
import 'hexagon_avatar.dart';

/// Search delegate for finding persons in the family tree
class PersonSearchDelegate extends SearchDelegate<String?> {
  final String treeId;
  final WidgetRef ref;
  final Function(String personId)? onPersonSelected;

  PersonSearchDelegate({
    required this.treeId,
    required this.ref,
    this.onPersonSelected,
  });

  @override
  String get searchFieldLabel => 'Search family members...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: theme.colorScheme.surface,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _buildEmptyState(context);
    }
    return _buildSearchResults(context);
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Search for family members',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Type a name to find someone in your tree',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    final searchResults = ref.watch(
      personSearchProvider((treeId: treeId, query: query)),
    );

    return searchResults.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
          ],
        ),
      ),
      data: (persons) {
        if (persons.isEmpty) {
          return _buildNoResults(context);
        }

        return ListView.builder(
          itemCount: persons.length,
          itemBuilder: (context, index) {
            final person = persons[index];
            return _PersonSearchTile(
              person: person,
              query: query,
              onTap: () {
                close(context, person.id);
                onPersonSelected?.call(person.id);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildNoResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No results for "$query"',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different name or spelling',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}

/// A tile showing a person in search results
class _PersonSearchTile extends StatelessWidget {
  final Person person;
  final String query;
  final VoidCallback? onTap;

  const _PersonSearchTile({
    required this.person,
    required this.query,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: HexagonAvatar(
        imageUrl: person.photoUrl,
        initials: person.initials,
        size: 48,
        isDeceased: person.isDeceased,
      ),
      title: _buildHighlightedName(context),
      subtitle: _buildSubtitle(),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildHighlightedName(BuildContext context) {
    final fullName = person.fullName;
    final lowerName = fullName.toLowerCase();
    final lowerQuery = query.toLowerCase();

    final matchIndex = lowerName.indexOf(lowerQuery);
    if (matchIndex == -1) {
      return Text(fullName);
    }

    final before = fullName.substring(0, matchIndex);
    final match = fullName.substring(matchIndex, matchIndex + query.length);
    final after = fullName.substring(matchIndex + query.length);

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(text: before),
          TextSpan(
            text: match,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          TextSpan(text: after),
        ],
      ),
    );
  }

  Widget? _buildSubtitle() {
    final parts = <String>[];

    if (person.age != null) {
      parts.add(person.isDeceased ? 'Died at ${person.age}' : 'Age ${person.age}');
    }

    if (person.location != null && person.location!.isNotEmpty) {
      parts.add(person.location!);
    }

    if (person.nickname != null && person.nickname!.isNotEmpty) {
      parts.add('"${person.nickname}"');
    }

    if (parts.isEmpty) return null;
    return Text(parts.join(' • '));
  }
}

/// A search bar widget that can be placed in the app bar
class TreeSearchBar extends ConsumerWidget {
  final String treeId;
  final Function(String personId)? onPersonSelected;

  const TreeSearchBar({
    super.key,
    required this.treeId,
    this.onPersonSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.search),
      tooltip: 'Search family members',
      onPressed: () async {
        final result = await showSearch<String?>(
          context: context,
          delegate: PersonSearchDelegate(
            treeId: treeId,
            ref: ref,
            onPersonSelected: onPersonSelected,
          ),
        );

        if (result != null) {
          onPersonSelected?.call(result);
        }
      },
    );
  }
}

