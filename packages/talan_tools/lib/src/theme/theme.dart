import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';

/// Custom theme for Talan Design System
abstract class TalanAppTheme {
  /// Light theme implementation
  static ThemeData get light {
    return common.copyWith(
      splashColor: TalanAppColors.n300,
      hintColor: TalanAppColors.n300,
      canvasColor: TalanAppColors.light,
      scaffoldBackgroundColor: TalanAppColors.n100,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: TalanAppColors.black,
        selectionColor: TalanAppColors.primary.shade300,
      ),
      brightness: Brightness.light,
      textTheme: TalanTextTheme.lightTextTheme,
      elevatedButtonTheme: TalanButtonThemes.elevatedButtonLightTheme,
      outlinedButtonTheme: TalanButtonThemes.outlinedButtonLightTheme,
      textButtonTheme: TalanButtonThemes.textButtonLightTheme,
      inputDecorationTheme: TalanInputTheme.inputDecorationLightTheme,
      appBarTheme: TalanAppbarTheme.lightAppbarTheme,
      bottomAppBarTheme: TalanBottomAppbarTheme.lightBottomAppbarTheme,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: TalanAppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: TalanAppColors.light,
      ),
      colorScheme: lightColorScheme,
      timePickerTheme: TimePickerThemeData(
        // backgroundColor: TalanAppColors.n400,
        dialHandColor: TalanAppColors.primary,
        dialTextColor: Colors.black, // Color de los numeros en el reloj
        dayPeriodColor: TalanAppColors.n300, // Background del AM - PM selector
        hourMinuteColor: TalanAppColors.n300,
        // dayPeriodTextColor: Colors.white, // Texto del AM - PM selector
        // entryModeIconColor: Colors.amber, // Cambia de reloj a input
        dialBackgroundColor: TalanAppColors.n300, // Background del reloj
        hourMinuteTextColor: TalanAppColors.primary,
        dayPeriodBorderSide: BorderSide.none,
      ),
      datePickerTheme: DatePickerThemeData(
        headerForegroundColor: TalanAppColors.light,
        headerBackgroundColor: TalanAppColors.primary,
        todayBackgroundColor:
            const MaterialStatePropertyAll(Colors.transparent),
        todayForegroundColor: MaterialStatePropertyAll(TalanAppColors.primary),
        dayBackgroundColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return TalanAppColors.primary;
            }
            return Colors.transparent;
          },
        ),
      ),
      dialogBackgroundColor: TalanAppColors.n100,
    );
  }

  /// Dark theme implementation
  static ThemeData get dark {
    return common.copyWith(
      splashColor: TalanAppColors.n800,
      hintColor: TalanAppColors.n800,
      canvasColor: TalanAppColors.black,
      scaffoldBackgroundColor: TalanAppColors.n800,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: TalanAppColors.light,
        selectionColor: TalanAppColors.primary.shade300,
      ),
      brightness: Brightness.dark,
      textTheme: TalanTextTheme.darkTextTheme,
      elevatedButtonTheme: TalanButtonThemes.elevatedButtonDarkTheme,
      outlinedButtonTheme: TalanButtonThemes.outlinedButtonDarkTheme,
      textButtonTheme: TalanButtonThemes.textButtonDarkTheme,
      inputDecorationTheme: TalanInputTheme.inputDecorationDarkTheme,
      appBarTheme: TalanAppbarTheme.darkAppbarTheme,
      bottomAppBarTheme: TalanBottomAppbarTheme.darkBottomAppbarTheme,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: TalanAppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: TalanAppColors.n800,
      ),
      colorScheme: darkColorScheme,
      timePickerTheme: TimePickerThemeData(
        // backgroundColor: TalanAppColors.n400,
        dialHandColor: TalanAppColors.primary,
        dialTextColor: Colors.white, // Color de los numeros en el reloj
        dayPeriodColor: TalanAppColors.n600, // Background del AM - PM selector
        hourMinuteColor: TalanAppColors.n600,
        // dayPeriodTextColor: Colors.white, // Texto del AM - PM selector
        // entryModeIconColor: Colors.amber, // Cambia de reloj a input
        dialBackgroundColor: TalanAppColors.n600, // Background del reloj
        hourMinuteTextColor: TalanAppColors.primary,
        dayPeriodBorderSide: BorderSide.none,
      ),
      datePickerTheme: DatePickerThemeData(
        headerForegroundColor: TalanAppColors.light,
        headerBackgroundColor: TalanAppColors.n800,
        todayBackgroundColor:
            const MaterialStatePropertyAll(Colors.transparent),
        todayForegroundColor: MaterialStatePropertyAll(TalanAppColors.primary),
        todayBorder: BorderSide(color: TalanAppColors.primary),
        dayBackgroundColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return TalanAppColors.primary;
            }
            return Colors.transparent;
          },
        ),
      ),
      dialogBackgroundColor: TalanAppColors.n800,
    );
  }

  /// Common theme properties
  static ThemeData get common {
    return ThemeData(
      useMaterial3: false,
      fontFamily: 'Montserrat',
      primaryColor: TalanAppColors.primary,
      primarySwatch: TalanAppColors.primary,
      iconTheme: iconTheme,
      progressIndicatorTheme: progressIndicatorTheme,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: TalanAppColors.callToAction,
        splashColor: TalanAppColors.primary.shade800,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: TalanAppColors.callToAction,
        unselectedItemColor: TalanAppColors.n700,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        showUnselectedLabels: true,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return TalanAppColors.callToAction;
            }
            return null;
          },
        ),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return TalanAppColors.callToAction.withAlpha(140);
            }
            return null;
          },
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return TalanAppColors.callToAction;
            }
            return TalanAppColors.n600;
          },
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      chipTheme: const ChipThemeData(
        showCheckmark: false,
        selectedColor: TalanAppColors.callToAction,
        backgroundColor: TalanAppColors.n300,
        disabledColor: TalanAppColors.n300,
        labelStyle: TextStyle(
          color: TalanAppColors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
        secondaryLabelStyle: TextStyle(
          color: TalanAppColors.light,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
        brightness: Brightness.light,
      ),
      dividerColor: TalanAppColors.n500,
      disabledColor: TalanAppColors.n500,
    );
  }

  /// Custom light color theme
  static ColorScheme get lightColorScheme {
    return ThemeData.light().colorScheme.copyWith(
          background: TalanAppColors.white,
          onBackground: TalanAppColors.dark,
          error: TalanAppColors.error,
          primary: TalanAppColors.white,
        );
  }

  /// Custom dark color theme
  static ColorScheme get darkColorScheme {
    return ThemeData.dark().colorScheme.copyWith(
          background: TalanAppColors.dark,
          onBackground: TalanAppColors.white,
          error: TalanAppColors.error,
          primary: TalanAppColors.dark,
        );
  }

  /// Custom theme for Icons
  static IconThemeData get iconTheme {
    return const IconThemeData(
      color: TalanAppColors.callToAction,
    );
  }

  /// Custom theme for progress indicator
  static ProgressIndicatorThemeData get progressIndicatorTheme {
    return ProgressIndicatorThemeData(color: TalanAppColors.primary);
  }
}
