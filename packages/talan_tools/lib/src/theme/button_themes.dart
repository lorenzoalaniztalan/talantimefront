import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';

/// Theme properties for buttons
class TalanButtonThemes {
  /// Elevated button for dark theme
  static ElevatedButtonThemeData get elevatedButtonDarkTheme {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll<EdgeInsets>(_buttonsPadding),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return TalanAppColors.n300;
          }
          return TalanAppColors.primary.shade600;
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return TalanAppColors.n400;
          }
          return TalanAppColors.light;
        }),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(TalanAppDimensions.borderRadiusControllers * 1.5),
            ),
          ),
        ),
        textStyle: const MaterialStatePropertyAll<TextStyle>(_textStyles),
      ),
    );
  }

  /// Elevated button for light theme
  static ElevatedButtonThemeData get elevatedButtonLightTheme {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll<EdgeInsets>(_buttonsPadding),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return TalanAppColors.n300;
          }
          return TalanAppColors.primary.shade600;
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return TalanAppColors.n400;
          }
          return TalanAppColors.light;
        }),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(TalanAppDimensions.borderRadiusControllers * 1.5),
            ),
          ),
        ),
        textStyle: const MaterialStatePropertyAll<TextStyle>(_textStyles),
      ),
    );
  }

  /// Outlined button for dark theme
  static OutlinedButtonThemeData get outlinedButtonDarkTheme {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll<EdgeInsets>(_buttonsPadding),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              TalanAppDimensions.borderRadiusControllers * 1.5,
            ),
          ),
        ),
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return BorderSide(
                color: TalanAppColors.n600,
                width: TalanAppDimensions.borderWidth,
              );
            }
            return BorderSide(
              color: TalanAppColors.primary,
              width: TalanAppDimensions.borderWidth,
            );
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return TalanAppColors.n600;
          }
          return TalanAppColors.primary;
        }),
        textStyle: const MaterialStatePropertyAll<TextStyle>(_textStyles),
      ),
    );
  }

  /// Outlined button for light theme
  static OutlinedButtonThemeData get outlinedButtonLightTheme {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll<EdgeInsets>(_buttonsPadding),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              TalanAppDimensions.borderRadiusControllers * 1.5,
            ),
          ),
        ),
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return BorderSide(
                color: TalanAppColors.n500,
                width: TalanAppDimensions.borderWidth,
              );
            }
            return BorderSide(
              color: TalanAppColors.primary,
              width: TalanAppDimensions.borderWidth,
            );
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return TalanAppColors.n500;
          }
          return TalanAppColors.primary;
        }),
        textStyle: const MaterialStatePropertyAll<TextStyle>(_textStyles),
      ),
    );
  }

  /// Text button theme for light theme
  static TextButtonThemeData get textButtonLightTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: _buttonsPadding,
        foregroundColor: TalanAppColors.primary,
        textStyle: _textStyles,
      ),
    );
  }

  /// Text button theme for dark theme
  static TextButtonThemeData get textButtonDarkTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: _buttonsPadding,
        foregroundColor: TalanAppColors.primary,
        textStyle: _textStyles,
      ),
    );
  }
}

const _buttonsPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 15);
const _textStyles = TextStyle(
  fontWeight: FontWeight.w600,
  fontFamily: 'Montserrat',
);
