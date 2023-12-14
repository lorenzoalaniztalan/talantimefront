import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/home/widgets/sub_view_wrapper.dart';
import 'package:turnotron/l10n/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    required this.onNavigateEditUsualSchedule,
    super.key,
  });
  final void Function() onNavigateEditUsualSchedule;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return HomePageSubViewWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TalanText.headlineMedium(
            text: l10n.settingsPageTitle,
            style: TextStyle(
              color: Theme.of(context).textTheme.labelLarge?.color,
            ),
          ),
          spacerM,
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: TalanText.bodyLarge(
              text: l10n.settingsPageSubtitleOne,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: onNavigateEditUsualSchedule,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(l10n.settingsPageSubtitleOneLink),
                  spacerXs,
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
