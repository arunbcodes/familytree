import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

import '../../../data/models/person.dart';
import '../../../data/models/relationship.dart';

/// Graph layout algorithm types
enum GraphAlgorithm {
  buchheimerWalker, // Hierarchical tree
  fruchtermanReingold, // Force-directed
  sugiyama, // Layered graph
}

/// TreeCanvas implementation using the graphview package
/// Provides professional graph layouts with smooth animations
class GraphTreeCanvas extends StatefulWidget {
  final List<Person> persons;
  final List<Relationship> relationships;
  final String centerPersonId;
  final GraphAlgorithm algorithm;
  final Function(String personId)? onPersonTap;
  final Function(String personId)? onPersonDoubleTap;
  final Function(String personId)? onPersonLongPress;

  const GraphTreeCanvas({
    super.key,
    required this.persons,
    required this.relationships,
    required this.centerPersonId,
    this.algorithm = GraphAlgorithm.buchheimerWalker,
    this.onPersonTap,
    this.onPersonDoubleTap,
    this.onPersonLongPress,
  });

  @override
  State<GraphTreeCanvas> createState() => _GraphTreeCanvasState();
}

class _GraphTreeCanvasState extends State<GraphTreeCanvas> {
  final Graph _graph = Graph();
  late Algorithm _algorithm;
  final TransformationController _transformController = TransformationController();
  String? _selectedPersonId;
  final Map<String, Node> _nodeMap = {};

  @override
  void initState() {
    super.initState();
    _buildGraph();
    _setupAlgorithm();
  }

  @override
  void didUpdateWidget(GraphTreeCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.persons != widget.persons ||
        oldWidget.relationships != widget.relationships ||
        oldWidget.algorithm != widget.algorithm) {
      _graph.nodes.clear();
      _graph.edges.clear();
      _nodeMap.clear();
      _buildGraph();
      _setupAlgorithm();
    }
  }

  void _buildGraph() {
    // Create nodes for each person
    for (final person in widget.persons) {
      final node = Node.Id(person.id);
      _graph.addNode(node);
      _nodeMap[person.id] = node;
    }

    // Create edges for relationships
    for (final rel in widget.relationships) {
      final node1 = _nodeMap[rel.person1Id];
      final node2 = _nodeMap[rel.person2Id];
      if (node1 != null && node2 != null) {
        _graph.addEdge(node1, node2, paint: _getEdgePaint(rel.type));
      }
    }
  }

  Paint _getEdgePaint(RelationshipType type) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    switch (type) {
      case RelationshipType.parentChild:
        paint.color = Colors.blue.shade400;
        break;
      case RelationshipType.spouse:
        paint.color = Colors.red.shade400;
        break;
      case RelationshipType.sibling:
      case RelationshipType.halfSibling:
        paint.color = Colors.green.shade400;
        break;
      case RelationshipType.exSpouse:
        paint.color = Colors.grey.shade400;
        paint.strokeWidth = 1.5;
        break;
      default:
        paint.color = Colors.purple.shade300;
    }
    return paint;
  }

  void _setupAlgorithm() {
    switch (widget.algorithm) {
      case GraphAlgorithm.buchheimerWalker:
        _algorithm = BuchheimWalkerAlgorithm(
          BuchheimWalkerConfiguration()
            ..siblingSeparation = 80
            ..levelSeparation = 120
            ..subtreeSeparation = 100
            ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM,
          TreeEdgeRenderer(
            BuchheimWalkerConfiguration()
              ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM,
          ),
        );
        break;
      case GraphAlgorithm.fruchtermanReingold:
        _algorithm = FruchtermanReingoldAlgorithm(
          FruchtermanReingoldConfiguration(
            iterations: 100,
          ),
        );
        break;
      case GraphAlgorithm.sugiyama:
        _algorithm = SugiyamaAlgorithm(
          SugiyamaConfiguration()
            ..nodeSeparation = 80
            ..levelSeparation = 120
            ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM,
        );
        break;
    }
  }

  Person? _findPerson(String id) {
    try {
      return widget.persons.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.persons.isEmpty) {
      return const Center(
        child: Text('No family members yet'),
      );
    }

    return InteractiveViewer(
      transformationController: _transformController,
      constrained: false,
      boundaryMargin: const EdgeInsets.all(200),
      minScale: 0.1,
      maxScale: 3.0,
      child: GraphView(
        graph: _graph,
        algorithm: _algorithm,
        animated: true,
        builder: (Node node) {
          final personId = node.key!.value as String;
          final person = _findPerson(personId);

          if (person == null) {
            return const SizedBox(width: 80, height: 80);
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedPersonId = _selectedPersonId == personId ? null : personId;
              });
              widget.onPersonTap?.call(personId);
            },
            onDoubleTap: () => widget.onPersonDoubleTap?.call(personId),
            onLongPress: () => widget.onPersonLongPress?.call(personId),
            child: _GraphPersonNode(
              person: person,
              isSelected: _selectedPersonId == personId,
              isCenter: personId == widget.centerPersonId,
            ),
          );
        },
      ),
    );
  }
}

/// Compact person node for graph view
class _GraphPersonNode extends StatelessWidget {
  final Person person;
  final bool isSelected;
  final bool isCenter;

  const _GraphPersonNode({
    required this.person,
    this.isSelected = false,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelected
            ? (isDark ? Colors.blue.shade800 : Colors.blue.shade100)
            : (isDark ? Colors.grey.shade800 : Colors.white),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCenter
              ? Colors.amber
              : isSelected
                  ? Colors.blue
                  : (isDark ? Colors.grey.shade600 : Colors.grey.shade300),
          width: isCenter ? 3 : (isSelected ? 2 : 1),
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? Colors.blue.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: isSelected ? 12 : 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getAvatarColor(person),
              border: Border.all(
                color: person.isDeceased ? Colors.grey : Colors.white,
                width: 2,
              ),
            ),
            child: person.photoUrl != null
                ? ClipOval(
                    child: Image.network(
                      person.photoUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildInitials(),
                    ),
                  )
                : _buildInitials(),
          ),
          const SizedBox(height: 4),
          // Name
          Text(
            person.firstName,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: person.isDeceased
                  ? Colors.grey
                  : (isDark ? Colors.white : Colors.black87),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          if (person.lastName.isNotEmpty)
            Text(
              person.lastName,
              style: TextStyle(
                fontSize: 10,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          // Birth year
          if (person.birthDate != null)
            Text(
              person.isDeceased && person.deathDate != null
                  ? '${person.birthDate!.year} - ${person.deathDate!.year}'
                  : 'b. ${person.birthDate!.year}',
              style: TextStyle(
                fontSize: 9,
                color: Colors.grey.shade500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInitials() {
    return Center(
      child: Text(
        '${person.firstName.isNotEmpty ? person.firstName[0] : ''}${person.lastName.isNotEmpty ? person.lastName[0] : ''}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Color _getAvatarColor(Person person) {
    if (person.isDeceased) return Colors.grey.shade500;

    // Generate consistent color from name
    final hash = person.firstName.hashCode + person.lastName.hashCode;
    final colors = [
      Colors.blue,
      Colors.teal,
      Colors.indigo,
      Colors.purple,
      Colors.deepPurple,
      Colors.cyan,
    ];
    return colors[hash.abs() % colors.length];
  }
}
