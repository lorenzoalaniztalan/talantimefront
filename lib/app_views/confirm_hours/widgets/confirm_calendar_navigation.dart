import 'package:flutter/material.dart';
import 'package:turnotron/l10n/l10n.dart';

class ConfirmCalendarNavigation extends StatelessWidget {
  const ConfirmCalendarNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.scheduleConfirmHoursUnsavedTitle),
      content: Text(
        l10n.scheduleConfirmHoursUnsavedMessage,
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            l10n.scheduleConfirmHoursUnsavedContinue,
          ),
        )
      ],
    );
  }
}
