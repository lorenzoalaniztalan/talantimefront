import 'package:flutter/material.dart';

/// Text implementation for the Wid Design System
class TalanText extends StatelessWidget {
  /// Constructor
  const TalanText({
    required this.text,
    this.variant = TalanTextVariant.bodyMedium,
    this.textAlign,
    this.style,
    super.key,
  });

  /// Text widget implementing displayLarge styles
  const TalanText.displayLarge({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.displayLarge;

  /// Text widget implementing displayMedium styles
  const TalanText.displayMedium({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.displayMedium;

  /// Text widget implementing displaySmall styles
  const TalanText.displaySmall({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.displaySmall;

  /// Text widget implementing headlineLarge styles
  const TalanText.headlineLarge({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.headlineLarge;

  /// Text widget implementing headlineMedium styles
  const TalanText.headlineMedium({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.headlineMedium;

  /// Text widget implementing headlineSmall styles
  const TalanText.headlineSmall({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.headlineSmall;

  /// Text widget implementing titleLarge styles
  const TalanText.titleLarge({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.titleLarge;

  /// Text widget implementing bodyLarge styles
  const TalanText.bodyLarge({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.bodyLarge;

  /// Text widget implementing bodyMedium styles
  const TalanText.bodyMedium({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.bodyMedium;

  /// Text widget implementing bodySmall styles
  const TalanText.bodySmall({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.bodySmall;

  /// Text widget implementing labelLarge styles
  const TalanText.labelLarge({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.labelLarge;

  /// Text widget implementing labelMedium styles
  const TalanText.labelMedium({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.labelMedium;

  /// Text widget implementing labelSmall styles
  const TalanText.labelSmall({
    required this.text,
    this.textAlign,
    this.style,
    super.key,
  }) : variant = TalanTextVariant.labelSmall;

  /// Text to display
  final String text;

  /// The set of predefined text styles
  final TalanTextVariant variant;

  /// Text alignment
  final TextAlign? textAlign;

  /// Custom styles
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: getStylesFromContextByVariant(context, variant)
          ?.merge(style ?? const TextStyle()),
    );
  }
}

/// Returns text styles from the Theme context based on the text variant
TextStyle? getStylesFromContextByVariant(
  BuildContext context,
  TalanTextVariant variant,
) {
  final textTheme = Theme.of(context).textTheme;
  if (variant == TalanTextVariant.displayLarge) return textTheme.displayLarge;
  if (variant == TalanTextVariant.displayMedium) return textTheme.displayMedium;
  if (variant == TalanTextVariant.displaySmall) return textTheme.displaySmall;
  if (variant == TalanTextVariant.headlineLarge) return textTheme.headlineLarge;
  if (variant == TalanTextVariant.headlineMedium) {
    return textTheme.headlineMedium;
  }
  if (variant == TalanTextVariant.headlineSmall) return textTheme.headlineSmall;
  if (variant == TalanTextVariant.titleLarge) return textTheme.titleLarge;
  if (variant == TalanTextVariant.bodyLarge) return textTheme.bodyLarge;
  if (variant == TalanTextVariant.bodyMedium) return textTheme.bodyMedium;
  if (variant == TalanTextVariant.bodySmall) return textTheme.bodySmall;
  if (variant == TalanTextVariant.labelLarge) return textTheme.labelLarge;
  if (variant == TalanTextVariant.labelMedium) return textTheme.labelMedium;
  if (variant == TalanTextVariant.labelSmall) return textTheme.labelSmall;
  return textTheme.bodyMedium;
}

/// Variants with predefined styles for displaying texts
enum TalanTextVariant {
  /// Implements text styles from Theme.textContext.displayLarge
  displayLarge,

  /// Implements text styles from Theme.textContext.displayMedium
  displayMedium,

  /// Implements text styles from Theme.textContext.displaySmall
  displaySmall,

  /// Implements text styles from Theme.textContext.headlineLarge
  headlineLarge,

  /// Implements text styles from Theme.textContext.headlineMedium
  headlineMedium,

  /// Implements text styles from Theme.textContext.headlineSmall
  headlineSmall,

  /// Implements text styles from Theme.textContext.titleLarge
  titleLarge,

  /// Implements text styles from Theme.textContext.bodyLarge
  bodyLarge,

  /// Implements text styles from Theme.textContext.bodyMedium
  bodyMedium,

  /// Implements text styles from Theme.textContext.bodySmall
  bodySmall,

  /// Implements text styles from Theme.textContext.labelLarge
  labelLarge,

  /// Implements text styles from Theme.textContext.labelMedium
  labelMedium,

  /// Implements text styles from Theme.textContext.labelSmall
  labelSmall,
}
