import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';

/// BottomAppbar theme implementation
class TalanBottomAppbarTheme {
  /// Custom light theme
  static BottomAppBarTheme get lightBottomAppbarTheme {
    return const BottomAppBarTheme(
      color: TalanAppColors.white,
      surfaceTintColor: TalanAppColors.black,
      shadowColor: TalanAppColors.black,
    );
  }

  /// Custom dark theme
  static BottomAppBarTheme get darkBottomAppbarTheme {
    return const BottomAppBarTheme(
      color: TalanAppColors.black,
      surfaceTintColor: TalanAppColors.white,
      shadowColor: TalanAppColors.white,
    );
  }
}
