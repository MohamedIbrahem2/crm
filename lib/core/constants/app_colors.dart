import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  static const Color primaryYellow = Color(0xFFFFC300); // Yellow
  static const Color secondaryYellow = Color(0xFFFFD700); // A slightly different yellow for variety
  static const Color darkBlue = Color(0xFF001D3D); // Very dark blue (Main color)


  // Alternative colors to match with primaryYellow and darkBlue
  static const Color alternativeYellow = Color(0xFFFFE600); // Bright yellow
  static const Color alternativeDarkBlue = Color(0xFF002D72); // Alternative dark blue
  static const Color lightYellow = Color(0xFFFFF9E5); // Soft, light yellow for background or accents
  static const Color lightBlue = Color(0xFF4A5D81); // Soft blue to complement dark blue

  static const Color white = Colors.white; // White for text or background
  static const Color backgroundGray = Color(0xFFF8F9FA); // Light gray background
}

