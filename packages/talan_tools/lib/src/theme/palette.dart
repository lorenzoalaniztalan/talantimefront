import 'package:flutter/material.dart';

/// Primary color
const Color _primary = Color(0xFF2EA0E6);

final Map<int, Color> _pink = {
  50: const Color(0xFFE6EEF5),
  100: const Color(0xFFDEEFFF),
  200: const Color(0xFFC1D3E5),
  300: const Color(0xFF94DBF7),
  400: const Color(0xFF81B5E9),
  500: _primary,
  600: const Color(0xFF108BE9),
  700: const Color(0xFF0078D4),
  800: const Color(0xFF0064B1),
  900: const Color(0xFF005291),
};

/// Color palette for Talan Design System
class TalanAppColors {
  /// Call-to-action color
  static const Color dark = Color(0xFF1C1C1C);

  /// Call-to-action color
  static const Color light = Color(0xFFFEFEFE);

  /// Call-to-action color
  static const Color callToAction = Color(0xFF4100B4);

  /// Color for success/completion feedback
  static const Color success = Color(0xFF56BD54);

  /// Color for info/warning feedback
  static const Color info = Color(0xFFFFC914);

  /// Color for error/alert feedback
  static const Color error = Color(0xFFEB2B35);

  /// Custom yellow color
  static const Color yellow = Color(0xFFFFC914);

  /// Custom white color
  static const Color white = Color(0xFFFEFEFE);

  /// Custom black color
  static const Color black = Color(0xFF1C1C1C);

  /// Custom grey color (shade 100)
  static const Color n100 = Color(0xFFF6F6F6);

  /// Custom grey color (shade 200)
  static const Color n200 = Color(0xFFEAEAEA);

  /// Custom grey color (shade 300)
  static const Color n300 = Color(0xFFD2D3D3);

  /// Custom grey color (shade 400)
  static const Color n400 = Color(0xFFB1B2B2);

  /// Custom grey color (shade 500)
  static const Color n500 = Color(0xFF8E9090);

  /// Custom grey color (shade 600)
  static const Color n600 = Color(0xFF7A7A7A);

  /// Custom grey color (shade 700)
  static const Color n700 = Color(0xFF6B6B6B);

  /// Custom grey color (shade 800)
  static const Color n800 = Color(0xFF363939);

  /// Custom grey color (shade 900)
  static const Color n900 = Color(0xFF252729);

  /// Background color
  static const Color background = white;

  /// Primary color
  static MaterialColor primary = MaterialColor(_primary.value, _pink);
}
