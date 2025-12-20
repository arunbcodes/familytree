import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../data/models/relationship.dart';

/// Paints relationship edges between nodes on the canvas
class RelationshipEdgePainter extends CustomPainter {
  final List<Relationship> relationships;
  final Map<String, Offset> nodePositions;
  final Offset canvasOffset;
  final String? selectedPersonId;
  final double scale;
  final bool showLabels;

  RelationshipEdgePainter({
    required this.relationships,
    required this.nodePositions,
    required this.canvasOffset,
    this.selectedPersonId,
    this.scale = 1.0,
    this.showLabels = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final relationship in relationships) {
      final pos1 = nodePositions[relationship.person1Id];
      final pos2 = nodePositions[relationship.person2Id];

      if (pos1 == null || pos2 == null) continue;

      final start = canvasOffset + pos1;
      final end = canvasOffset + pos2;

      final isHighlighted = selectedPersonId == relationship.person1Id ||
          selectedPersonId == relationship.person2Id;

      _drawEdge(canvas, start, end, relationship, isHighlighted);

      if (showLabels && scale > 0.6) {
        _drawLabel(canvas, start, end, relationship, isHighlighted);
      }
    }
  }

  void _drawEdge(
    Canvas canvas,
    Offset start,
    Offset end,
    Relationship relationship,
    bool isHighlighted,
  ) {
    final paint = Paint()
      ..color = isHighlighted
          ? relationship.type.color
          : relationship.type.color.withValues(alpha: 0.5)
      ..strokeWidth = isHighlighted ? 3.0 : 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // For ex-spouse, use dashed line
    if (relationship.type == RelationshipType.exSpouse) {
      _drawDashedLine(canvas, start, end, paint);
    } else {
      canvas.drawLine(start, end, paint);
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 8.0;
    const dashSpace = 4.0;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = math.sqrt(dx * dx + dy * dy);
    final dashCount = (distance / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCount; i++) {
      final startFraction = i * (dashWidth + dashSpace) / distance;
      final endFraction = (i * (dashWidth + dashSpace) + dashWidth) / distance;

      if (endFraction > 1) break;

      final dashStart = Offset(
        start.dx + dx * startFraction,
        start.dy + dy * startFraction,
      );
      final dashEnd = Offset(
        start.dx + dx * endFraction,
        start.dy + dy * endFraction,
      );

      canvas.drawLine(dashStart, dashEnd, paint);
    }
  }

  void _drawLabel(
    Canvas canvas,
    Offset start,
    Offset end,
    Relationship relationship,
    bool isHighlighted,
  ) {
    // Only show label for highlighted edges to reduce clutter
    if (!isHighlighted) return;

    final midpoint = Offset(
      (start.dx + end.dx) / 2,
      (start.dy + end.dy) / 2,
    );

    final label = relationship.type.labelFromPerson1;

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: relationship.type.color,
          fontSize: 10 * scale,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.white.withValues(alpha: 0.8),
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // Draw background
    final bgRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: midpoint,
        width: textPainter.width + 8,
        height: textPainter.height + 4,
      ),
      const Radius.circular(4),
    );

    canvas.drawRRect(
      bgRect,
      Paint()..color = Colors.white.withValues(alpha: 0.9),
    );

    // Draw text
    textPainter.paint(
      canvas,
      Offset(
        midpoint.dx - textPainter.width / 2,
        midpoint.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant RelationshipEdgePainter oldDelegate) {
    return oldDelegate.relationships != relationships ||
        oldDelegate.nodePositions != nodePositions ||
        oldDelegate.selectedPersonId != selectedPersonId ||
        oldDelegate.scale != scale;
  }
}

/// A widget wrapper for the edge painter
class RelationshipEdges extends StatelessWidget {
  final List<Relationship> relationships;
  final Map<String, Offset> nodePositions;
  final Offset canvasOffset;
  final String? selectedPersonId;
  final double scale;
  final Size canvasSize;

  const RelationshipEdges({
    super.key,
    required this.relationships,
    required this.nodePositions,
    required this.canvasOffset,
    this.selectedPersonId,
    this.scale = 1.0,
    required this.canvasSize,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: canvasSize,
      painter: RelationshipEdgePainter(
        relationships: relationships,
        nodePositions: nodePositions,
        canvasOffset: canvasOffset,
        selectedPersonId: selectedPersonId,
        scale: scale,
        showLabels: scale > 0.6,
      ),
    );
  }
}

/// Animated edge that grows from source to target
class AnimatedRelationshipEdge extends StatefulWidget {
  final Offset start;
  final Offset end;
  final RelationshipType type;
  final Duration duration;
  final VoidCallback? onComplete;

  const AnimatedRelationshipEdge({
    super.key,
    required this.start,
    required this.end,
    required this.type,
    this.duration = const Duration(milliseconds: 300),
    this.onComplete,
  });

  @override
  State<AnimatedRelationshipEdge> createState() => _AnimatedRelationshipEdgeState();
}

class _AnimatedRelationshipEdgeState extends State<AnimatedRelationshipEdge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _controller.forward().then((_) {
      widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _AnimatedEdgePainter(
            start: widget.start,
            end: widget.end,
            type: widget.type,
            progress: _animation.value,
          ),
        );
      },
    );
  }
}

class _AnimatedEdgePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final RelationshipType type;
  final double progress;

  _AnimatedEdgePainter({
    required this.start,
    required this.end,
    required this.type,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = type.color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final currentEnd = Offset(
      start.dx + (end.dx - start.dx) * progress,
      start.dy + (end.dy - start.dy) * progress,
    );

    canvas.drawLine(start, currentEnd, paint);
  }

  @override
  bool shouldRepaint(covariant _AnimatedEdgePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
