import 'package:flutter/material.dart';
import '../../../data/models/person.dart';
import '../../../core/constants/app_sizes.dart';
import 'hexagon_avatar.dart';

/// Represents a person's position in the tree canvas
class NodePosition {
  final String personId;
  Offset position;
  bool isVisible;
  bool isExpanded; // Have connections been loaded/shown?
  double scale; // For LOD (level of detail)

  NodePosition({
    required this.personId,
    required this.position,
    this.isVisible = true,
    this.isExpanded = false,
    this.scale = 1.0,
  });

  NodePosition copyWith({
    String? personId,
    Offset? position,
    bool? isVisible,
    bool? isExpanded,
    double? scale,
  }) {
    return NodePosition(
      personId: personId ?? this.personId,
      position: position ?? this.position,
      isVisible: isVisible ?? this.isVisible,
      isExpanded: isExpanded ?? this.isExpanded,
      scale: scale ?? this.scale,
    );
  }
}

/// A complete person node widget for the tree canvas
/// Includes hexagon avatar, name label, and optional expand button
class PersonNode extends StatelessWidget {
  final Person person;
  final bool isSelected;
  final bool isCenter; // Is this the center/focus person?
  final bool showExpandButton;
  final double scale;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onExpand;

  const PersonNode({
    super.key,
    required this.person,
    this.isSelected = false,
    this.isCenter = false,
    this.showExpandButton = false,
    this.scale = 1.0,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = AppSizes.hexagonMedium * scale;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Hexagon avatar
        Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedHexagonAvatar(
              imageUrl: person.photoUrl,
              initials: person.initials,
              size: avatarSize,
              isDeceased: person.isDeceased,
              isSelected: isSelected,
              isElderlyAssisted: person.isElderlyAssisted,
              onTap: onTap,
              onDoubleTap: onDoubleTap,
              onLongPress: onLongPress,
            ),
            // Center person indicator
            if (isCenter)
              Positioned(
                top: -8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'You',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10 * scale,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            // Expand button
            if (showExpandButton)
              Positioned(
                bottom: -4,
                right: -4,
                child: GestureDetector(
                  onTap: onExpand,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 14 * scale,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 4 * scale),
        // Name label
        _buildNameLabel(context),
      ],
    );
  }

  Widget _buildNameLabel(BuildContext context) {
    // Show simplified label at small scales
    if (scale < 0.7) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints: BoxConstraints(maxWidth: AppSizes.hexagonMedium * 1.5 * scale),
      padding: EdgeInsets.symmetric(
        horizontal: 8 * scale,
        vertical: 2 * scale,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        person.displayName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12 * scale,
          fontWeight: isCenter ? FontWeight.bold : FontWeight.normal,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// A simplified node for when zoomed out (LOD optimization)
class SimplifiedPersonNode extends StatelessWidget {
  final Person person;
  final bool isSelected;
  final double size;
  final VoidCallback? onTap;

  const SimplifiedPersonNode({
    super.key,
    required this.person,
    this.isSelected = false,
    this.size = 24,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: person.isDeceased ? Colors.grey : Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            person.initials[0],
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget for adding a new person (placeholder node)
class AddPersonNode extends StatelessWidget {
  final double size;
  final String? label;
  final VoidCallback? onTap;

  const AddPersonNode({
    super.key,
    this.size = AppSizes.hexagonMedium,
    this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(
            painter: HexagonBorderPainter(
              borderColor: Colors.grey.shade400,
              borderWidth: 2,
              fillColor: Colors.grey.shade100,
            ),
            child: SizedBox(
              width: size,
              height: size * 1.1547,
              child: Center(
                child: Icon(
                  Icons.add,
                  size: size * 0.4,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
          if (label != null) ...[
            const SizedBox(height: 4),
            Text(
              label!,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
