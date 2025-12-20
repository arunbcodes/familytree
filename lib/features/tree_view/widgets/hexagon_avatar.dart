import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

/// A hexagonal avatar widget for displaying person photos in the family tree
class HexagonAvatar extends StatelessWidget {
  /// URL of the image to display (null for placeholder)
  final String? imageUrl;

  /// Initials to show when no image is available
  final String initials;

  /// Size of the hexagon (width)
  final double size;

  /// Whether this person is deceased (affects styling)
  final bool isDeceased;

  /// Whether this avatar is currently selected
  final bool isSelected;

  /// Whether this person is elderly/assisted (shows indicator)
  final bool isElderlyAssisted;

  /// Callback when the avatar is tapped
  final VoidCallback? onTap;

  /// Callback when the avatar is double-tapped
  final VoidCallback? onDoubleTap;

  /// Callback when the avatar is long-pressed
  final VoidCallback? onLongPress;

  const HexagonAvatar({
    super.key,
    this.imageUrl,
    required this.initials,
    this.size = AppSizes.hexagonMedium,
    this.isDeceased = false,
    this.isSelected = false,
    this.isElderlyAssisted = false,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    // Hexagon height is approximately 1.1547 times the width for flat-top hexagon
    final height = size * 1.1547;

    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: size,
        height: height,
        child: Stack(
          children: [
            // Main hexagon with content
            CustomPaint(
              painter: HexagonBorderPainter(
                borderColor: _getBorderColor(),
                borderWidth: isSelected ? 3.0 : 2.0,
                fillColor: _getBackgroundColor(context),
              ),
              child: ClipPath(
                clipper: HexagonClipper(),
                child: _buildContent(context),
              ),
            ),
            // Elderly assisted indicator
            if (isElderlyAssisted)
              Positioned(
                right: 0,
                bottom: height * 0.1,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: AppColors.elderlyAssisted,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.accessibility_new,
                    size: size * 0.2,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getBorderColor() {
    if (isSelected) {
      return AppColors.hexBorderSelected;
    }
    if (isDeceased) {
      return AppColors.hexBorderDeceased;
    }
    return AppColors.hexBorderDefault;
  }

  Color _getBackgroundColor(BuildContext context) {
    if (isDeceased) {
      return Colors.grey.shade200;
    }
    return AppColors.primary.withValues(alpha: 0.1);
  }

  Widget _buildContent(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        width: size,
        height: size * 1.1547,
        placeholder: (context, url) => _buildInitialsPlaceholder(context),
        errorWidget: (context, url, error) => _buildInitialsPlaceholder(context),
        color: isDeceased ? Colors.grey : null,
        colorBlendMode: isDeceased ? BlendMode.saturation : null,
      );
    }
    return _buildInitialsPlaceholder(context);
  }

  Widget _buildInitialsPlaceholder(BuildContext context) {
    return Container(
      width: size,
      height: size * 1.1547,
      color: isDeceased ? Colors.grey.shade300 : AppColors.primary.withValues(alpha: 0.2),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: size * 0.35,
            fontWeight: FontWeight.bold,
            color: isDeceased ? Colors.grey.shade600 : AppColors.primary,
          ),
        ),
      ),
    );
  }
}

/// Clips content into a hexagon shape (flat-top orientation)
class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return _createHexagonPath(size);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// Draws the hexagon border
class HexagonBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final Color? fillColor;

  HexagonBorderPainter({
    required this.borderColor,
    required this.borderWidth,
    this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _createHexagonPath(size);

    // Fill if color provided
    if (fillColor != null) {
      final fillPaint = Paint()
        ..color = fillColor!
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);
    }

    // Draw border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant HexagonBorderPainter oldDelegate) {
    return oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.fillColor != fillColor;
  }
}

/// Creates a hexagon path (flat-top orientation)
/// Flat-top means the flat edges are at top and bottom
Path _createHexagonPath(Size size) {
  final path = Path();
  final centerX = size.width / 2;
  final centerY = size.height / 2;
  final radius = size.width / 2;

  for (int i = 0; i < 6; i++) {
    // Flat-top hexagon: start at 30 degrees offset
    // This ensures flat edges are at top and bottom
    final angle = (60 * i - 30) * math.pi / 180;
    final x = centerX + radius * math.cos(angle);
    final y = centerY + radius * math.sin(angle);

    if (i == 0) {
      path.moveTo(x, y);
    } else {
      path.lineTo(x, y);
    }
  }

  path.close();
  return path;
}

/// Animated hexagon avatar with scale and glow effects
class AnimatedHexagonAvatar extends StatefulWidget {
  final String? imageUrl;
  final String initials;
  final double size;
  final bool isDeceased;
  final bool isSelected;
  final bool isElderlyAssisted;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;

  const AnimatedHexagonAvatar({
    super.key,
    this.imageUrl,
    required this.initials,
    this.size = AppSizes.hexagonMedium,
    this.isDeceased = false,
    this.isSelected = false,
    this.isElderlyAssisted = false,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
  });

  @override
  State<AnimatedHexagonAvatar> createState() => _AnimatedHexagonAvatarState();
}

class _AnimatedHexagonAvatarState extends State<AnimatedHexagonAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: AppSizes.animationFast),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(AnimatedHexagonAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.forward();
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: HexagonAvatar(
            imageUrl: widget.imageUrl,
            initials: widget.initials,
            size: widget.size,
            isDeceased: widget.isDeceased,
            isSelected: widget.isSelected,
            isElderlyAssisted: widget.isElderlyAssisted,
            onTap: widget.onTap,
            onDoubleTap: widget.onDoubleTap,
            onLongPress: widget.onLongPress,
          ),
        );
      },
    );
  }
}
