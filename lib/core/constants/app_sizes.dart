/// App-wide size constants
class AppSizes {
  AppSizes._();

  // Hexagon avatar sizes
  static const double hexagonSmall = 48.0;
  static const double hexagonMedium = 80.0;
  static const double hexagonLarge = 120.0;

  // Minimum touch target (accessibility)
  static const double minTouchTarget = 48.0;

  // Spacing
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // Border radius
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;

  // Graph layout
  static const double nodeSpacing = 150.0;
  static const double edgeThickness = 2.0;
  static const double edgeThicknessSelected = 3.0;

  // Canvas
  static const double canvasSize = 4000.0;
  static const double canvasCenter = canvasSize / 2;

  // Animation durations (ms)
  static const int animationFast = 150;
  static const int animationNormal = 300;
  static const int animationSlow = 500;

  // Zoom levels
  static const double minZoom = 0.3;
  static const double maxZoom = 3.0;
  static const double defaultZoom = 1.0;

  // Level of Detail thresholds
  static const int lodSimplifiedThreshold = 50; // Show simplified nodes when > 50 visible
  static const double lodZoomThreshold = 0.5; // Show simplified when zoom < 0.5
}
