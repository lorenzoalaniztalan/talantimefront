// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';

/// Button implementation with variants
class TalanButton extends StatelessWidget {
  /// Constructor
  const TalanButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.variant = TalanButtonVariant.contained,
    this.disabled = false,
  });

  /// Text to display
  final String text;

  /// Callback function
  final VoidCallback onPressed;

  /// contained, outlined, text, callToAction
  final TalanButtonVariant variant;

  /// Disabled
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    Widget button;
    switch (variant) {
      case TalanButtonVariant.contained:
        button = ElevatedButton(
          onPressed: disabled ? null : onPressed,
          child: TalanText(
            text: text,
            variant: TalanTextVariant.headlineSmall,
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        );
      case TalanButtonVariant.text:
        button = TextButton(
          onPressed: disabled ? null : onPressed,
          child: TalanText(
            text: text,
            variant: TalanTextVariant.headlineSmall,
          ),
        );
      case TalanButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: disabled ? null : onPressed,
          child: TalanText(
            text: text,
            variant: TalanTextVariant.headlineSmall,
          ),
        );
      case TalanButtonVariant.callToAction:
        button = ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: TalanAppColors.callToAction,
          ).merge(Theme.of(context).elevatedButtonTheme.style),
          child: TalanText(
            text: text,
            variant: TalanTextVariant.headlineSmall,
          ),
        );
    }
    return button;
  }
}

/// Variants for buttons
enum TalanButtonVariant {
  /// No borders, background color contrasts the scaffoldBackgroundColor
  contained,

  /// No borders, no background
  text,

  /// Outlined border, outline border color same as text, no background
  outlined,

  /// No borders, background color is TalanAppColors.callToAction
  callToAction
}
