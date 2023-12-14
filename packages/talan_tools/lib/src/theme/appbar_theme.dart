import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talan_tools/talan_tools.dart';

/// Appbar theme implementation
class TalanAppbarTheme {
  /// Custom light appbar theme
  static AppBarTheme get lightAppbarTheme {
    return AppBarTheme(
      centerTitle: false,
      foregroundColor: TalanAppColors.light,
      backgroundColor: TalanAppColors.primary.shade700,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
      shadowColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: TalanAppColors.light,
      ),
    );
  }

  /// Custom dark appbar theme
  static AppBarTheme get darkAppbarTheme {
    return AppBarTheme(
      centerTitle: false,
      foregroundColor: TalanAppColors.black,
      backgroundColor: TalanAppColors.primary.shade700,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: TalanAppColors.black,
      ),
    );
  }
}
