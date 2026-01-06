import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/models/person.dart';
import '../../data/models/relationship.dart';

/// Minimum node size for collision calculations (hexagon width + padding)
const double _minNodeSize = 100.0;

/// Utility class for calculating graph layouts
class GraphLayout {
  GraphLayout._();

  /// Calculate positions for a radial/force-directed layout
  /// Places the center person at origin, others in concentric circles
  static Map<String, Offset> calculateRadialLayout({
    required String centerPersonId,
    required List<Person> persons,
    required List<Relationship> relationships,
    double nodeSpacing = 200.0,
  }) {
    final positions = <String, Offset>{};
    final visited = <String>{};
    final layerNodes = <int, List<String>>{}; // Track nodes per layer

    // Place center person at origin
    positions[centerPersonId] = Offset.zero;
    visited.add(centerPersonId);

    // First pass: BFS to assign layers
    final queue = <_LayoutNode>[_LayoutNode(centerPersonId, 0)];
    final nodeToLayer = <String, int>{centerPersonId: 0};

    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      layerNodes.putIfAbsent(current.layer, () => []);
      if (current.layer > 0) {
        layerNodes[current.layer]!.add(current.personId);
      }

      final connections = _getConnectedPersonIds(current.personId, relationships);
      for (final connectedId in connections) {
        if (!visited.contains(connectedId)) {
          visited.add(connectedId);
          nodeToLayer[connectedId] = current.layer + 1;
          queue.add(_LayoutNode(connectedId, current.layer + 1));
        }
      }
    }

    // Second pass: Position nodes in each ring with adaptive spacing
    for (final entry in layerNodes.entries) {
      final layer = entry.key;
      if (layer == 0) continue; // Center already at origin

      final nodesInLayer = entry.value;
      final nodeCount = nodesInLayer.length;

      // Calculate minimum radius needed to prevent node overlaps
      // Each node needs at least _minNodeSize arc length between centers
      // Arc length = radius * angle, so for nodeCount nodes:
      // circumference >= nodeCount * max(nodeSpacing, _minNodeSize)
      final effectiveSpacing = math.max(nodeSpacing, _minNodeSize);
      final minRadiusForSpacing = (nodeCount * effectiveSpacing) / (2 * math.pi);
      
      // Base radius grows with each layer, ensuring outer rings are larger
      final baseRadius = layer * nodeSpacing * 1.2; // 20% extra per layer
      
      // Use whichever is larger to prevent overlaps
      final radius = math.max(baseRadius, minRadiusForSpacing);

      final angleStep = 2 * math.pi / math.max(nodeCount, 1);
      // Offset angle per layer to create staggered effect
      final baseAngle = (layer % 2 == 0) ? 0.0 : angleStep / 2;

      for (int i = 0; i < nodeCount; i++) {
        final nodeId = nodesInLayer[i];
        final angle = baseAngle + angleStep * i - math.pi / 2; // Start from top

        positions[nodeId] = Offset(
          radius * math.cos(angle),
          radius * math.sin(angle),
        );
      }
    }

    // Add any unconnected persons (shouldn't happen normally)
    for (final person in persons) {
      if (!positions.containsKey(person.id)) {
        positions[person.id] = Offset(
          (positions.length % 5) * nodeSpacing,
          (positions.length ~/ 5) * nodeSpacing,
        );
      }
    }

    return positions;
  }

  /// Calculate positions for a hierarchical tree layout
  /// Good for displaying parent-child relationships clearly
  static Map<String, Offset> calculateTreeLayout({
    required String rootPersonId,
    required List<Person> persons,
    required List<Relationship> relationships,
    double horizontalSpacing = 120.0,
    double verticalSpacing = 150.0,
  }) {
    final positions = <String, Offset>{};
    final levels = <int, List<String>>{};
    final visited = <String>{};

    // BFS to assign levels
    final queue = <_LayoutNode>[_LayoutNode(rootPersonId, 0)];
    visited.add(rootPersonId);

    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      levels.putIfAbsent(current.layer, () => []).add(current.personId);

      final children = _getChildrenIds(current.personId, relationships);
      for (final childId in children) {
        if (!visited.contains(childId)) {
          visited.add(childId);
          queue.add(_LayoutNode(childId, current.layer + 1));
        }
      }
    }

    // Position each level
    for (final entry in levels.entries) {
      final level = entry.key;
      final nodesAtLevel = entry.value;
      final totalWidth = (nodesAtLevel.length - 1) * horizontalSpacing;
      final startX = -totalWidth / 2;

      for (int i = 0; i < nodesAtLevel.length; i++) {
        positions[nodesAtLevel[i]] = Offset(
          startX + i * horizontalSpacing,
          level * verticalSpacing,
        );
      }
    }

    return positions;
  }

  /// Calculate positions for a sunburst/radial hierarchy layout
  /// Great for showing generations as concentric rings
  static Map<String, Offset> calculateSunburstLayout({
    required String centerPersonId,
    required List<Person> persons,
    required List<Relationship> relationships,
    double ringSpacing = 180.0,
  }) {
    final positions = <String, Offset>{};
    final visited = <String>{};

    // Center person at origin
    positions[centerPersonId] = Offset.zero;
    visited.add(centerPersonId);

    // Assign rings (generations) using BFS
    final rings = <int, List<String>>{};
    final queue = <_LayoutNode>[_LayoutNode(centerPersonId, 0)];

    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      rings.putIfAbsent(current.layer, () => []);
      if (current.layer > 0) {
        rings[current.layer]!.add(current.personId);
      }

      final connections = _getConnectedPersonIds(current.personId, relationships);
      for (final connectedId in connections) {
        if (!visited.contains(connectedId)) {
          visited.add(connectedId);
          queue.add(_LayoutNode(connectedId, current.layer + 1));
        }
      }
    }

    // Position each ring with adaptive spacing
    for (final entry in rings.entries) {
      final ring = entry.key;
      if (ring == 0) continue; // Center already positioned

      final nodesInRing = entry.value;
      final nodeCount = nodesInRing.length;

      // Calculate minimum radius needed to prevent node overlaps
      final effectiveSpacing = math.max(ringSpacing, _minNodeSize);
      final minRadiusForSpacing = (nodeCount * effectiveSpacing) / (2 * math.pi);
      
      // Base radius grows with each ring, with extra padding
      final baseRadius = ring * ringSpacing * 1.2;
      
      // Use whichever is larger to prevent overlaps
      final radius = math.max(baseRadius, minRadiusForSpacing);

      final angleStep = 2 * math.pi / nodeCount;
      // Stagger alternate rings for better visual separation
      final baseAngle = (ring % 2 == 0) ? 0.0 : angleStep / 2;

      for (int i = 0; i < nodeCount; i++) {
        final angle = baseAngle + angleStep * i - math.pi / 2; // Start from top
        positions[nodesInRing[i]] = Offset(
          radius * math.cos(angle),
          radius * math.sin(angle),
        );
      }
    }

    return positions;
  }

  /// Simple force-directed layout simulation
  /// Nodes repel each other, edges act as springs
  static Map<String, Offset> applyForceDirectedLayout({
    required Map<String, Offset> initialPositions,
    required List<Relationship> relationships,
    int iterations = 50,
    double repulsionStrength = 5000.0,
    double attractionStrength = 0.1,
    double damping = 0.9,
  }) {
    final positions = Map<String, Offset>.from(initialPositions);
    final velocities = <String, Offset>{};

    for (final id in positions.keys) {
      velocities[id] = Offset.zero;
    }

    for (int iter = 0; iter < iterations; iter++) {
      final forces = <String, Offset>{};

      // Initialize forces
      for (final id in positions.keys) {
        forces[id] = Offset.zero;
      }

      // Repulsion between all nodes
      final ids = positions.keys.toList();
      for (int i = 0; i < ids.length; i++) {
        for (int j = i + 1; j < ids.length; j++) {
          final id1 = ids[i];
          final id2 = ids[j];
          final pos1 = positions[id1]!;
          final pos2 = positions[id2]!;

          final dx = pos2.dx - pos1.dx;
          final dy = pos2.dy - pos1.dy;
          final distance = math.max(math.sqrt(dx * dx + dy * dy), 1.0);

          final force = repulsionStrength / (distance * distance);
          final fx = (dx / distance) * force;
          final fy = (dy / distance) * force;

          forces[id1] = Offset(forces[id1]!.dx - fx, forces[id1]!.dy - fy);
          forces[id2] = Offset(forces[id2]!.dx + fx, forces[id2]!.dy + fy);
        }
      }

      // Attraction along edges
      for (final rel in relationships) {
        final pos1 = positions[rel.person1Id];
        final pos2 = positions[rel.person2Id];

        if (pos1 == null || pos2 == null) continue;

        final dx = pos2.dx - pos1.dx;
        final dy = pos2.dy - pos1.dy;
        final distance = math.sqrt(dx * dx + dy * dy);

        final force = distance * attractionStrength;
        final fx = (dx / math.max(distance, 1.0)) * force;
        final fy = (dy / math.max(distance, 1.0)) * force;

        forces[rel.person1Id] = Offset(
          forces[rel.person1Id]!.dx + fx,
          forces[rel.person1Id]!.dy + fy,
        );
        forces[rel.person2Id] = Offset(
          forces[rel.person2Id]!.dx - fx,
          forces[rel.person2Id]!.dy - fy,
        );
      }

      // Apply forces
      for (final id in positions.keys) {
        velocities[id] = Offset(
          (velocities[id]!.dx + forces[id]!.dx) * damping,
          (velocities[id]!.dy + forces[id]!.dy) * damping,
        );

        positions[id] = Offset(
          positions[id]!.dx + velocities[id]!.dx,
          positions[id]!.dy + velocities[id]!.dy,
        );
      }
    }

    return positions;
  }

  /// Get all person IDs connected to a given person
  static List<String> _getConnectedPersonIds(
    String personId,
    List<Relationship> relationships,
  ) {
    final connected = <String>[];
    for (final rel in relationships) {
      if (rel.person1Id == personId) {
        connected.add(rel.person2Id);
      } else if (rel.person2Id == personId) {
        connected.add(rel.person1Id);
      }
    }
    return connected;
  }

  /// Get children IDs (person2 where relationship is parentChild and person1 is parent)
  static List<String> _getChildrenIds(
    String personId,
    List<Relationship> relationships,
  ) {
    return relationships
        .where((rel) =>
            rel.type == RelationshipType.parentChild && rel.person1Id == personId)
        .map((rel) => rel.person2Id)
        .toList();
  }
}

/// Helper class for BFS traversal
class _LayoutNode {
  final String personId;
  final int layer;

  _LayoutNode(this.personId, this.layer);
}

/// Enum for layout types
enum LayoutType {
  radial,
  tree,
  sunburst,
  forceDirected,
}
