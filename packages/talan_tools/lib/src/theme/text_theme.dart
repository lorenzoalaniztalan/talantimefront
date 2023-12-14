import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';

/// Text theme implementation
class TalanTextTheme {
  /// Custom light text theme
  static TextTheme get lightTextTheme {
    return Typography.blackCupertino.merge(defaultTextTheme).apply(
          // bodyColor: TalanAppColors.dark,
          // displayColor: TalanAppColors.dark,
          fontFamily: 'Montserrat',
        );
  }

  /// Custom dark text theme
  static TextTheme get darkTextTheme {
    return Typography.whiteCupertino.merge(defaultTextTheme).apply(
          // bodyColor: TalanAppColors.dark,
          // displayColor: TalanAppColors.dark,
          fontFamily: 'Montserrat',
        );
  }

  /// Custom text theme
  static TextTheme get defaultTextTheme {
    return TextTheme(
      displayLarge: TalanTextStyle.headerStyles.copyWith(fontSize: 38),

      /// H2
      displayMedium: TalanTextStyle.headerStyles.copyWith(fontSize: 32),

      /// H3
      displaySmall: TalanTextStyle.headerStyles.copyWith(fontSize: 24),

      /// H3
      headlineLarge: TalanTextStyle.headerStyles.copyWith(fontSize: 24),

      /// H4
      headlineMedium: TalanTextStyle.headerStyles.copyWith(fontSize: 18),

      /// H5
      headlineSmall: TalanTextStyle.headerStyles.copyWith(fontSize: 14),

      /// H3
      titleLarge: TalanTextStyle.headerStyles.copyWith(fontSize: 24),
      bodyLarge: TalanTextStyle.bodyStyles,
      bodyMedium: TalanTextStyle.bodyStyles.copyWith(fontSize: 14),
      bodySmall: TalanTextStyle.bodyStyles.copyWith(fontSize: 12),
      labelLarge: TalanTextStyle.labelStyles,
      labelMedium: TalanTextStyle.labelStyles.copyWith(fontSize: 14),
      labelSmall: TalanTextStyle.labelStyles.copyWith(fontSize: 12),
    );
  }
}
