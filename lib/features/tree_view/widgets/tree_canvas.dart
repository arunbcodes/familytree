import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/graph_layout.dart';
import '../../../data/models/person.dart';
import '../../../data/models/relationship.dart';
import 'person_node.dart';
import 'relationship_edge.dart';

/// The main interactive canvas for displaying the family tree
class TreeCanvas extends StatefulWidget {
  final List<Person> persons;
  final List<Relationship> relationships;
  final String centerPersonId;
  final LayoutType layoutType;
  final Function(String personId)? onPersonTap;
  final Function(String personId)? onPersonLongPress;
  final Function(String personId)? onExpandPerson;
  final Function(Offset position)? onAddPerson;

  const TreeCanvas({
    super.key,
    required this.persons,
    required this.relationships,
    required this.centerPersonId,
    this.layoutType = LayoutType.radial,
    this.onPersonTap,
    this.onPersonLongPress,
    this.onExpandPerson,
    this.onAddPerson,
  });

  @override
  State<TreeCanvas> createState() => _TreeCanvasState();
}

class _TreeCanvasState extends State<TreeCanvas> with TickerProviderStateMixin {
  final TransformationController _transformController = TransformationController();
  Map<String, Offset> _nodePositions = {};
  String? _selectedPersonId;
  double _currentScale = 1.0;

  // Animation controllers
  late AnimationController _appearAnimController;

  @override
  void initState() {
    super.initState();
    _appearAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppSizes.animationSlow),
    );

    _calculateLayout();
    _centerOnPerson(widget.centerPersonId);

    _appearAnimController.forward();
  }

  @override
  void didUpdateWidget(TreeCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Recalculate layout if data or layout type changed
    if (oldWidget.persons != widget.persons ||
        oldWidget.relationships != widget.relationships ||
        oldWidget.layoutType != widget.layoutType ||
        oldWidget.centerPersonId != widget.centerPersonId) {
      _calculateLayout();
    }
  }

  @override
  void dispose() {
    _transformController.dispose();
    _appearAnimController.dispose();
    super.dispose();
  }

  void _calculateLayout() {
    switch (widget.layoutType) {
      case LayoutType.radial:
        _nodePositions = GraphLayout.calculateRadialLayout(
          centerPersonId: widget.centerPersonId,
          persons: widget.persons,
          relationships: widget.relationships,
          nodeSpacing: AppSizes.nodeSpacing,
        );
        break;
      case LayoutType.tree:
        _nodePositions = GraphLayout.calculateTreeLayout(
          rootPersonId: widget.centerPersonId,
          persons: widget.persons,
          relationships: widget.relationships,
        );
        break;
      case LayoutType.sunburst:
        _nodePositions = GraphLayout.calculateSunburstLayout(
          centerPersonId: widget.centerPersonId,
          persons: widget.persons,
          relationships: widget.relationships,
        );
        break;
      case LayoutType.forceDirected:
        // Start with radial, then apply forces
        final initial = GraphLayout.calculateRadialLayout(
          centerPersonId: widget.centerPersonId,
          persons: widget.persons,
          relationships: widget.relationships,
        );
        _nodePositions = GraphLayout.applyForceDirectedLayout(
          initialPositions: initial,
          relationships: widget.relationships,
        );
        break;
    }
  }

  void _centerOnPerson(String personId) {
    final position = _nodePositions[personId];
    if (position == null) return;

    // Schedule centering after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final screenSize = MediaQuery.of(context).size;
      final centerX = screenSize.width / 2;
      final centerY = screenSize.height / 2;

      // Calculate translation to center the person
      final canvasCenter = Offset(AppSizes.canvasCenter, AppSizes.canvasCenter);
      final personCanvasPos = canvasCenter + position;

      final translation = Matrix4.identity()
        ..setTranslationRaw(
          centerX - personCanvasPos.dx,
          centerY - personCanvasPos.dy,
          0,
        );

      _transformController.value = translation;
    });
  }

  void _onTransformChanged() {
    final scale = _transformController.value.getMaxScaleOnAxis();
    if (scale != _currentScale) {
      setState(() {
        _currentScale = scale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (details) {
        // Double tap to zoom in/out
        final currentScale = _transformController.value.getMaxScaleOnAxis();
        final newScale = currentScale < 1.5 ? 2.0 : 1.0;

        final position = details.localPosition;
        final scaleFactor = newScale / currentScale;
        
        // Create zoom transformation centered on tap position
        // Scale matrix with translation to keep zoom centered on tap
        final scaleMatrix = Matrix4.diagonal3Values(scaleFactor, scaleFactor, 1);
        final translateMatrix = Matrix4.translationValues(
          position.dx * (1 - scaleFactor),
          position.dy * (1 - scaleFactor),
          0,
        );
        final matrix = translateMatrix * scaleMatrix;

        _transformController.value = matrix * _transformController.value;
      },
      child: InteractiveViewer(
        transformationController: _transformController,
        minScale: AppSizes.minZoom,
        maxScale: AppSizes.maxZoom,
        constrained: false,
        boundaryMargin: const EdgeInsets.all(double.infinity),
        onInteractionUpdate: (_) => _onTransformChanged(),
        child: SizedBox(
          width: AppSizes.canvasSize,
          height: AppSizes.canvasSize,
          child: Stack(
            children: [
              // Background grid (optional, for visual reference)
              if (_currentScale > 0.5) _buildGrid(),

              // Relationship edges (drawn first, behind nodes)
              RelationshipEdges(
                relationships: widget.relationships,
                nodePositions: _nodePositions,
                canvasOffset: const Offset(AppSizes.canvasCenter, AppSizes.canvasCenter),
                selectedPersonId: _selectedPersonId,
                scale: _currentScale,
                canvasSize: const Size(AppSizes.canvasSize, AppSizes.canvasSize),
              ),

              // Person nodes
              ..._buildNodes(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return CustomPaint(
      size: const Size(AppSizes.canvasSize, AppSizes.canvasSize),
      painter: _GridPainter(
        gridSize: 50,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.03),
      ),
    );
  }

  List<Widget> _buildNodes() {
    final nodes = <Widget>[];
    final useLOD = _currentScale < AppSizes.lodZoomThreshold ||
        widget.persons.length > AppSizes.lodSimplifiedThreshold;

    for (final person in widget.persons) {
      final position = _nodePositions[person.id];
      if (position == null) continue;

      final canvasPos = Offset(
        AppSizes.canvasCenter + position.dx,
        AppSizes.canvasCenter + position.dy,
      );

      // Use simplified nodes when zoomed out or many nodes
      if (useLOD) {
        nodes.add(
          Positioned(
            left: canvasPos.dx - 12,
            top: canvasPos.dy - 12,
            child: SimplifiedPersonNode(
              person: person,
              isSelected: _selectedPersonId == person.id,
              onTap: () => _handlePersonTap(person.id),
            ),
          ),
        );
      } else {
        final nodeScale = _currentScale.clamp(0.5, 1.5);

        nodes.add(
          Positioned(
            left: canvasPos.dx - (AppSizes.hexagonMedium * nodeScale) / 2,
            top: canvasPos.dy - (AppSizes.hexagonMedium * 1.1547 * nodeScale) / 2,
            child: FadeTransition(
              opacity: _appearAnimController,
              child: PersonNode(
                person: person,
                isSelected: _selectedPersonId == person.id,
                isCenter: person.id == widget.centerPersonId,
                showExpandButton: _selectedPersonId == person.id,
                scale: nodeScale,
                onTap: () => _handlePersonTap(person.id),
                onLongPress: () => widget.onPersonLongPress?.call(person.id),
                onExpand: () => widget.onExpandPerson?.call(person.id),
              ),
            ),
          ),
        );
      }
    }

    return nodes;
  }

  void _handlePersonTap(String personId) {
    setState(() {
      _selectedPersonId = _selectedPersonId == personId ? null : personId;
    });
    widget.onPersonTap?.call(personId);
  }
}

/// Painter for background grid
class _GridPainter extends CustomPainter {
  final double gridSize;
  final Color color;

  _GridPainter({required this.gridSize, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    // Vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.gridSize != gridSize || oldDelegate.color != color;
  }
}
