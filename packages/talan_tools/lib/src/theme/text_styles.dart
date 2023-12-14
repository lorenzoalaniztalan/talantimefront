import 'package:flutter/cupertino.dart';

/// Class for managing the text styles used in Talan Design System
abstract class TalanTextStyle {
  /// Text styles for labels
  static const TextStyle labelStyles = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  /// Text styles for input fields
  static const TextStyle inputStyles = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  /// Text styles for button labels
  static const TextStyle buttonTextStyles = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  /// Text styles for header-like texts
  static const TextStyle headerStyles = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  /// Text styles for header-like texts
  static const TextStyle bodyStyles = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  /// Default text styles
  static const TextStyle defaultStyles = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
  );
}
