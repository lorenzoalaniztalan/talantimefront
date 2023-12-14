import 'package:flutter/material.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/home/widgets/sub_view_wrapper.dart';
import 'package:turnotron/l10n/l10n.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({
    required this.handleRegisterNavigation,
    required this.handleReportNavigation,
    super.key,
  });
  final void Function() handleRegisterNavigation;
  final void Function() handleReportNavigation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return HomePageSubViewWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TalanText.headlineMedium(
            text: l10n.adminPageTitle,
            style: TextStyle(
              color: Theme.of(context).textTheme.labelLarge?.color,
            ),
          ),
          spacerM,
          _SectionItem(
            text: l10n.adminPageSubtitleOne,
            buttonLabel: l10n.linkToRegister,
            buttonCallback: handleRegisterNavigation,
          ),
          spacerM,
          _SectionItem(
            text: l10n.generateReportSubtitle,
            buttonLabel: l10n.generateReportCallToActionButton,
            buttonCallback: handleReportNavigation,
          ),
        ],
      ),
    );
  }
}

class _SectionItem extends StatelessWidget {
  const _SectionItem({
    required this.text,
    required this.buttonLabel,
    required this.buttonCallback,
  });
  final String text;
  final String buttonLabel;
  final void Function() buttonCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: TalanText.bodyLarge(
            text: text,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: buttonCallback,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(buttonLabel),
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
    );
  }
}
