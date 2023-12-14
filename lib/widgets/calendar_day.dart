import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/widgets/day_type_indicator.dart';

class CalendarDay extends StatelessWidget {
  const CalendarDay({
    required this.day,
    super.key,
    this.scheduleDay,
  });
  final DateTime day;
  final ScheduleDay? scheduleDay;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          spacerExpanded,
          JustTheTooltip(
            waitDuration: const Duration(milliseconds: 400),
            tailBaseWidth: 20,
            backgroundColor: TalanAppColors.n700,
            content: _TooltipWidget(
              day: scheduleDay,
            ),
            child: TalanText.bodyLarge(
              text: day.day.toString(),
            ),
          ),
          Expanded(
            child: ScheduleDayTypeIndicator(day: scheduleDay),
          ),
        ],
      ),
    );
  }
}

class _TooltipWidget extends StatelessWidget {
  const _TooltipWidget({required this.day});
  final ScheduleDay? day;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Builder(
        builder: (_) {
          if (day.runtimeType == WorkingDay) {
            return _WorkedDayHours(
              day: day! as WorkingDay,
            );
          }
          var text = l10n.noData;
          if (day.runtimeType == AbsenceDay) {
            text = l10n.absence;
          }
          if (day.runtimeType == NonWorkingDay) {
            text = l10n.bankHolidays;
          }
          return Text(
            text,
            style: const TextStyle(color: TalanAppColors.light),
          );
        },
      ),
    );
  }
}

class _WorkedDayHours extends StatelessWidget {
  const _WorkedDayHours({
    required this.day,
  });
  final WorkingDay day;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TalanText.bodyLarge(
                text: l10n.scheduleCheckIn,
                style: _textStyles,
              ),
              const _Separator(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  day.startOne,
                  style: _textStyles,
                ),
              )
            ],
          ),
          spacerXs,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TalanText.bodyLarge(
                text: l10n.scheduleRestStart,
                style: _textStyles,
              ),
              const _Separator(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  day.finishOne,
                  style: _textStyles,
                ),
              )
            ],
          ),
          spacerXs,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TalanText.bodyLarge(
                text: l10n.scheduleRestEnd,
                style: _textStyles,
              ),
              const _Separator(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  day.startTwo,
                  style: _textStyles,
                ),
              )
            ],
          ),
          spacerXs,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TalanText.bodyLarge(
                text: l10n.scheduleCheckOut,
                style: _textStyles,
              ),
              const _Separator(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  day.finishTwo,
                  style: _textStyles,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

const _textStyles = TextStyle(color: TalanAppColors.light);

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 20),
        child: spacerExpanded,
      ),
    );
  }
}
