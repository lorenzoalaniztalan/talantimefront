import 'package:flutter/material.dart';

/// Theme provider
class TalanThemeProvider extends ChangeNotifier {
  /// Add this theme to your providers (if implementing the provider library)
  TalanThemeProvider() {
    mode = TimeOfDay.now().hour > 18 ? ThemeMode.dark : ThemeMode.light;
  }

  /// dark or light
  late ThemeMode mode;

  /// Toggles the current theme
  void toggleThemeMode() {
    mode = mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
