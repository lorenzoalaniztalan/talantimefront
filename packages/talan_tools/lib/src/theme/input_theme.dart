import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';

/// Input theme implementation
class TalanInputTheme {
  /// Text input decoration for light theme
  static InputDecorationTheme get inputDecorationLightTheme {
    return InputDecorationTheme(
      isDense: true,
      isCollapsed: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      hintStyle: const TextStyle(color: TalanAppColors.n700),
      helperStyle: const TextStyle(color: TalanAppColors.n700),
      labelStyle: const TextStyle(color: TalanAppColors.n800),
      floatingLabelStyle: const TextStyle(color: TalanAppColors.n700),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: TalanAppColors.n300,
          width: TalanAppDimensions.borderWidth,
        ),
        borderRadius:
            BorderRadius.circular(TalanAppDimensions.borderRadiusControllers),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(TalanAppDimensions.borderRadiusControllers),
        borderSide: BorderSide(
          color: TalanAppColors.error,
          width: TalanAppDimensions.borderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(TalanAppDimensions.borderRadiusControllers),
        borderSide: BorderSide(
          color: TalanAppColors.primary,
          width: TalanAppDimensions.borderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(TalanAppDimensions.borderRadiusControllers),
        borderSide: BorderSide(
          color: TalanAppColors.n300,
          width: TalanAppDimensions.borderWidth,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(TalanAppDimensions.borderRadiusControllers),
        borderSide: BorderSide(
          color: TalanAppColors.n100,
          width: TalanAppDimensions.borderWidth,
        ),
      ),
    );
  }

  /// Text input decoration for dark theme
  static InputDecorationTheme get inputDecorationDarkTheme {
    return InputDecorationTheme(
      isDense: true,
      isCollapsed: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      hintStyle: const TextStyle(color: TalanAppColors.n300),
      helperStyle: const TextStyle(color: TalanAppColors.n300),
      labelStyle: const TextStyle(color: TalanAppColors.n200),
      floatingLabelStyle: const TextStyle(color: TalanAppColors.n300),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: TalanAppColors.n200,
          width: TalanAppDimensions.borderWidth,
        ),
        borderRadius:
            BorderRadius.circular(TalanAppDimensions.borderRadiusControllers),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(TalanAppDimensions.borderRadiusControllers),
        borderSide: BorderSide(
          color: TalanAppColors.error,
          width: TalanAppDimensions.borderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(TalanAppDimensions.borderRadiusControllers),
        borderSide: BorderSide(
          color: TalanAppColors.primary,
          width: TalanAppDimensions.borderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(TalanAppDimensions.borderRadiusControllers),
        borderSide: BorderSide(
          color: TalanAppColors.n200,
          width: TalanAppDimensions.borderWidth,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(TalanAppDimensions.borderRadiusControllers),
        borderSide: BorderSide(
          color: TalanAppColors.n800,
          width: TalanAppDimensions.borderWidth,
        ),
      ),
    );
  }
}
