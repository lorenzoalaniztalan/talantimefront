import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/l10n/l10n.dart';

class TalanCopyrightFooter extends StatelessWidget {
  const TalanCopyrightFooter({
    super.key,
    this.variant = TalanFooterVariant.contain,
  });
  final TalanFooterVariant variant;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    var backgroundColor = Theme.of(context).appBarTheme.backgroundColor;
    var textColor = TalanAppColors.light;
    if (variant == TalanFooterVariant.justText) {
      backgroundColor = Colors.transparent;
      textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    }
    return DecoratedBox(
      decoration: BoxDecoration(color: backgroundColor),
      child: SizedBox(
        height: kToolbarHeight,
        width: double.infinity,
        child: Center(
          child: TalanText.headlineSmall(
            text: l10n.copyrights,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}

enum TalanFooterVariant { contain, justText }
