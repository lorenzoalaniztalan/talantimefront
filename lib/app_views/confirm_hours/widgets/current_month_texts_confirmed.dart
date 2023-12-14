import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/providers/locale_provider.dart';
import 'package:turnotron/l10n/l10n.dart';

class CurrentMonthTextsConfirmed extends StatelessWidget {
  const CurrentMonthTextsConfirmed({
    required this.today,
    super.key,
  });
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Provider.of<LocaleProvider>(context).locale.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TalanText.headlineMedium(
          text:
              '${l10n.scheduleConfirmedHoursTitle} ${DateFormat.yMMM(locale).format(today)}',
          style: TextStyle(
            color: Theme.of(context).textTheme.labelLarge?.color,
          ),
        ),
        spacerM,
        TalanText.bodyLarge(
          text:
              '${l10n.scheduleConfirmedHoursSubtitleOne} ${DateFormat.yMMM(locale).format(today)}.',
        ),
        spacerM,
        TalanText.bodyMedium(
          text: ' - ${l10n.scheduleConfirmedHoursSubtitleTwo}.',
        ),
      ],
    );
  }
}
