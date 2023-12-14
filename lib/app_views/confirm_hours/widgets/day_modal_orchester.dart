import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/view/edit_day_view.dart';
import 'package:turnotron/app_views/providers/locale_provider.dart';
import 'package:turnotron/l10n/l10n.dart';

class ScheduleDayOrchester extends StatelessWidget {
  const ScheduleDayOrchester({
    required this.day,
    this.onEditDate,
    super.key,
  });
  final ScheduleDay day;
  final void Function(List<ScheduleDay> day)? onEditDate;

  @override
  Widget build(BuildContext context) {
    if (day.runtimeType == AbsenceDay) {
      return _AbsenceContent(
        day: day as AbsenceDay,
        onEditAbsenceDate: onEditDate,
      );
    }
    if (day.runtimeType == NonWorkingDay) {
      return _NonWorkingDayContent(
        day: day as NonWorkingDay,
      );
    }
    if (day.runtimeType == WorkingDay) {
      return _WorkingDayContent(
        day: day as WorkingDay,
        onEditWorkingDate: onEditDate,
      );
    }
    final l10n = AppLocalizations.of(context);
    return Text(l10n.noData);
  }
}

class _AbsenceContent extends StatelessWidget {
  const _AbsenceContent({
    required this.day,
    this.onEditAbsenceDate,
  });
  final AbsenceDay day;
  final void Function(List<ScheduleDay> day)? onEditAbsenceDate;

  @override
  Widget build(BuildContext context) {
    return EditDayView(
      day: day,
      onEditDate: onEditAbsenceDate == null
          ? null
          : (value) {
              onEditAbsenceDate!(
                value,
              );
              Navigator.of(context).pop();
            },
    );
  }
}

class _NonWorkingDayContent extends StatelessWidget {
  const _NonWorkingDayContent({required this.day});
  final NonWorkingDay day;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Provider.of<LocaleProvider>(context).locale.toString();
    return AlertDialog(
      title: TalanText.headlineSmall(
        text: '${l10n.date} ${DateFormat.yMMMd(locale).format(
          DateTime(
            day.year,
            day.month,
            day.day,
          ),
        )}',
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.scheduleDayNonWorkingDayDescription),
          spacerM,
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.ok),
            ),
          )
        ],
      ),
    );
  }
}

class _WorkingDayContent extends StatelessWidget {
  const _WorkingDayContent({
    required this.day,
    this.onEditWorkingDate,
  });
  final WorkingDay day;
  final void Function(List<ScheduleDay> day)? onEditWorkingDate;

  @override
  Widget build(BuildContext context) {
    return EditDayView(
      day: day,
      onEditDate: onEditWorkingDate == null
          ? null
          : (value) {
              onEditWorkingDate!(value);
              Navigator.of(context).pop();
            },
    );
  }
}
