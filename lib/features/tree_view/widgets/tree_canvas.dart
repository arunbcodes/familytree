import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final double nodeSpacing;
  final Map<String, Offset>? customPositions;
  final Function(String personId)? onPersonTap;
  final Function(String personId)? onPersonDoubleTap;
  final Function(String personId)? onPersonLongPress;
  final Function(String personId)? onExpandPerson;
  final Function(Offset position)? onAddPerson;
  final Function(String personId, Offset position)? onPersonDragged;

  const TreeCanvas({
    super.key,
    required this.persons,
    required this.relationships,
    required this.centerPersonId,
    this.layoutType = LayoutType.radial,
    this.nodeSpacing = 250.0,
    this.customPositions,
    this.onPersonTap,
    this.onPersonDoubleTap,
    this.onPersonLongPress,
    this.onExpandPerson,
    this.onAddPerson,
    this.onPersonDragged,
  });

  @override
  State<TreeCanvas> createState() => _TreeCanvasState();
}

class _TreeCanvasState extends State<TreeCanvas> with TickerProviderStateMixin {
  final TransformationController _transformController = TransformationController();
  Map<String, Offset> _algorithmPositions = {};
  Map<String, Offset> _customPositions = {};
  String? _selectedPersonId;
  String? _draggingPersonId;
  double _currentScale = 1.0;

  // Animation controllers
  late AnimationController _appearAnimController;

  /// Get the effective position for a person (custom if set, otherwise algorithm)
  Map<String, Offset> get _nodePositions {
    final positions = Map<String, Offset>.from(_algorithmPositions);
    for (final entry in _customPositions.entries) {
      positions[entry.key] = entry.value;
    }
    return positions;
  }

  @override
  void initState() {
    super.initState();
    _appearAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppSizes.animationSlow),
    );

    // Load custom positions if provided
    if (widget.customPositions != null) {
      _customPositions = Map.from(widget.customPositions!);
    }

    _calculateLayout();
    _centerOnPerson(widget.centerPersonId);

    _appearAnimController.forward();
  }

  @override
  void didUpdateWidget(TreeCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Recalculate layout if data, layout type, or spacing changed
    if (oldWidget.persons != widget.persons ||
        oldWidget.relationships != widget.relationships ||
        oldWidget.layoutType != widget.layoutType ||
        oldWidget.centerPersonId != widget.centerPersonId ||
        oldWidget.nodeSpacing != widget.nodeSpacing) {
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
        _algorithmPositions = GraphLayout.calculateRadialLayout(
          centerPersonId: widget.centerPersonId,
          persons: widget.persons,
          relationships: widget.relationships,
          nodeSpacing: widget.nodeSpacing,
        );
        break;
      case LayoutType.tree:
        _algorithmPositions = GraphLayout.calculateTreeLayout(
          rootPersonId: widget.centerPersonId,
          persons: widget.persons,
          relationships: widget.relationships,
          horizontalSpacing: widget.nodeSpacing * 0.6,
          verticalSpacing: widget.nodeSpacing * 0.75,
        );
        break;
      case LayoutType.sunburst:
        _algorithmPositions = GraphLayout.calculateSunburstLayout(
          centerPersonId: widget.centerPersonId,
          persons: widget.persons,
          relationships: widget.relationships,
          ringSpacing: widget.nodeSpacing * 0.9,
        );
        break;
      case LayoutType.forceDirected:
        // Start with radial, then apply forces
        final initial = GraphLayout.calculateRadialLayout(
          centerPersonId: widget.centerPersonId,
          persons: widget.persons,
          relationships: widget.relationships,
          nodeSpacing: widget.nodeSpacing,
        );
        _algorithmPositions = GraphLayout.applyForceDirectedLayout(
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
    // Only trigger rebuild if scale crosses a threshold (reduces rebuilds)
    final shouldUpdate = (scale - _currentScale).abs() > 0.05 ||
        (_currentScale < AppSizes.lodZoomThreshold) != (scale < AppSizes.lodZoomThreshold);
    if (shouldUpdate) {
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
                  // Wrap in RepaintBoundary to isolate repaints
                  RepaintBoundary(
                    child: RelationshipEdges(
                      relationships: widget.relationships,
                      nodePositions: _nodePositions,
                      canvasOffset: const Offset(AppSizes.canvasCenter, AppSizes.canvasCenter),
                      selectedPersonId: _selectedPersonId,
                      scale: _currentScale,
                      canvasSize: const Size(AppSizes.canvasSize, AppSizes.canvasSize),
                    ),
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
    // Cache the grid to avoid rebuilding on every frame
    return RepaintBoundary(
      child: CustomPaint(
        size: const Size(AppSizes.canvasSize, AppSizes.canvasSize),
        isComplex: true,
        willChange: false,
        painter: _GridPainter(
          gridSize: 50,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.03),
        ),
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

      final isDragging = _draggingPersonId == person.id;
      final hasCustomPosition = _customPositions.containsKey(person.id);

      // Use simplified nodes when zoomed out or many nodes
      if (useLOD) {
        nodes.add(
          Positioned(
            left: canvasPos.dx - 12,
            top: canvasPos.dy - 12,
            child: GestureDetector(
              onPanStart: (_) => _handleDragStart(person.id),
              onPanUpdate: (details) => _handleDragUpdate(person.id, details),
              onPanEnd: (_) => _handleDragEnd(person.id),
              child: SimplifiedPersonNode(
                person: person,
                isSelected: _selectedPersonId == person.id,
                onTap: () => _handlePersonTap(person.id),
              ),
            ),
          ),
        );
      } else {
        final nodeScale = _currentScale.clamp(0.5, 1.5);

        nodes.add(
          Positioned(
            left: canvasPos.dx - (AppSizes.hexagonMedium * nodeScale) / 2,
            top: canvasPos.dy - (AppSizes.hexagonMedium * 1.1547 * nodeScale) / 2,
            child: GestureDetector(
              onPanStart: (_) => _handleDragStart(person.id),
              onPanUpdate: (details) => _handleDragUpdate(person.id, details),
              onPanEnd: (_) => _handleDragEnd(person.id),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  FadeTransition(
                    opacity: _appearAnimController,
                    child: AnimatedScale(
                      scale: isDragging ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 100),
                      child: PersonNode(
                        person: person,
                        isSelected: _selectedPersonId == person.id,
                        isCenter: person.id == widget.centerPersonId,
                        showExpandButton: _selectedPersonId == person.id,
                        scale: nodeScale,
                        onTap: () => _handlePersonTap(person.id),
                        onDoubleTap: () => _handlePersonDoubleTap(person.id),
                        onLongPress: () => widget.onPersonLongPress?.call(person.id),
                        onExpand: () => widget.onExpandPerson?.call(person.id),
                      ),
                    ),
                  ),
                  // Custom position indicator
                  if (hasCustomPosition)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: const Icon(
                          Icons.push_pin,
                          size: 8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return nodes;
  }

  void _handleDragStart(String personId) {
    HapticFeedback.selectionClick();
    setState(() {
      _draggingPersonId = personId;
    });
  }

  void _handleDragUpdate(String personId, DragUpdateDetails details) {
    // Convert screen delta to canvas delta (accounting for zoom)
    final scaledDelta = details.delta / _currentScale;

    setState(() {
      // Get current position (custom or algorithm)
      final currentPos = _customPositions[personId] ?? _algorithmPositions[personId];
      if (currentPos == null) return;

      // Update custom position
      _customPositions[personId] = Offset(
        currentPos.dx + scaledDelta.dx,
        currentPos.dy + scaledDelta.dy,
      );
    });
  }

  void _handleDragEnd(String personId) {
    final position = _customPositions[personId];
    if (position != null) {
      HapticFeedback.lightImpact();
      widget.onPersonDragged?.call(personId, position);
    }
    setState(() {
      _draggingPersonId = null;
    });
  }

  void _handlePersonTap(String personId) {
    setState(() {
      _selectedPersonId = _selectedPersonId == personId ? null : personId;
    });
    widget.onPersonTap?.call(personId);
  }

  void _handlePersonDoubleTap(String personId) {
    // Animate centering on the person
    _animateCenterOnPerson(personId);
    widget.onPersonDoubleTap?.call(personId);
  }

  void _animateCenterOnPerson(String personId) {
    final position = _nodePositions[personId];
    if (position == null) return;

    final screenSize = MediaQuery.of(context).size;
    final centerX = screenSize.width / 2;
    final centerY = screenSize.height / 2;

    // Calculate target translation
    final canvasCenter = Offset(AppSizes.canvasCenter, AppSizes.canvasCenter);
    final personCanvasPos = canvasCenter + position;

    // Get current scale
    final currentScale = _transformController.value.getMaxScaleOnAxis();

    // Create target matrix (preserve current scale)
    final targetMatrix = Matrix4.identity()
      ..setTranslationRaw(
        centerX - personCanvasPos.dx * currentScale,
        centerY - personCanvasPos.dy * currentScale,
        0,
      );
    targetMatrix.setEntry(0, 0, currentScale);
    targetMatrix.setEntry(1, 1, currentScale);

    // Animate to target
    final animation = Matrix4Tween(
      begin: _transformController.value,
      end: targetMatrix,
    ).animate(CurvedAnimation(
      parent: _appearAnimController,
      curve: Curves.easeInOutCubic,
    ));

    void listener() {
      _transformController.value = animation.value;
    }

    animation.addListener(listener);
    _appearAnimController.reset();
    _appearAnimController.forward().then((_) {
      animation.removeListener(listener);
    });
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
