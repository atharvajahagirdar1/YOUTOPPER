import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary visual direction:
  // - deep navy foundation
  // - YOUTOPPER blue accent
  // - restrained indigo/blue secondary accent
  // - semantic colors for success/warning/error/info

  static const Color primary = Color(0xFF0F4C81); // YOUTOPPER blue accent
  static const Color secondary = Color(0xFF3F51B5); // Restrained indigo/blue
  static const Color background = Color(0xFF001524); // Deep navy foundation
  static const Color surface = Color(0xFF00223A); // Slightly lighter navy
  static const Color surfaceElevated = Color(0xFF002B4A); // Elevated surface for cards
  
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textMuted = Colors.white54;

  // Semantic
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
}
