import 'package:flutter/material.dart';

/// App-wide color definitions
class AppColors {
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF6B4EAA);
  static const Color primaryLight = Color(0xFF9E85D1);
  static const Color primaryDark = Color(0xFF3D2878);

  // Secondary colors
  static const Color secondary = Color(0xFF4EAAA0);
  static const Color secondaryLight = Color(0xFF80D4CA);
  static const Color secondaryDark = Color(0xFF1E7A70);

  // Relationship colors
  static const Color parentChild = Color(0xFF5C6BC0);
  static const Color spouse = Color(0xFFEC407A);
  static const Color exSpouse = Color(0xFFAD1457);
  static const Color sibling = Color(0xFF66BB6A);
  static const Color halfSibling = Color(0xFF43A047);
  static const Color stepFamily = Color(0xFFFFB74D);
  static const Color adoptive = Color(0xFF29B6F6);
  static const Color godparent = Color(0xFFAB47BC);

  // Status colors
  static const Color living = Color(0xFF4CAF50);
  static const Color deceased = Color(0xFF9E9E9E);
  static const Color elderlyAssisted = Color(0xFFFFB74D);

  // Hexagon borders
  static const Color hexBorderDefault = Color(0xFF424242);
  static const Color hexBorderDeceased = Color(0xFF757575);
  static const Color hexBorderSelected = Color(0xFF6B4EAA);

  // Background colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Graph background
  static const Color canvasBackground = Color(0xFFFAFAFA);
  static const Color canvasBackgroundDark = Color(0xFF1A1A1A);
  static const Color gridLine = Color(0xFFE0E0E0);
  static const Color gridLineDark = Color(0xFF2A2A2A);
}
