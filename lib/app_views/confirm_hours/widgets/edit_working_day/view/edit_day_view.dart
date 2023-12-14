import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/bloc/day_type_bloc.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/bloc/edit_absence_day_bloc.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/bloc/edit_working_day_bloc.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/view/edit_absence_day_view.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/view/edit_working_day_view.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/widgets/day_type_title.dart';

class EditDayView extends StatelessWidget {
  const EditDayView({
    required this.day,
    this.onEditDate,
    super.key,
  });
  final ScheduleDay day;
  final void Function(List<ScheduleDay> day)? onEditDate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DayTypeBloc(
        startDate: day.toDateTime(),
        endDate: day.toDateTime(),
        isWorkingDay: day.runtimeType == WorkingDay,
        isReadOnly: onEditDate == null,
      ),
      child: _DayTypeSwitcher(
        day: day,
        onEditDate: onEditDate,
      ),
    );
  }
}

class _DayTypeSwitcher extends StatefulWidget {
  const _DayTypeSwitcher({
    required this.day,
    this.onEditDate,
  });
  final ScheduleDay day;
  final void Function(List<ScheduleDay> day)? onEditDate;

  @override
  State<_DayTypeSwitcher> createState() => __DayTypeSwitcher();
}

const _scrollDuration = Duration(milliseconds: 240);
const _scrollCurve = Curves.fastOutSlowIn;

class __DayTypeSwitcher extends State<_DayTypeSwitcher> {
  late ScrollController _controller;
  late bool reverse;

  @override
  void initState() {
    _controller = ScrollController();
    reverse = !context.read<DayTypeBloc>().state.dayType.isWorkingDay;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final day = widget.day;
    return BlocListener<DayTypeBloc, DayTypeState>(
      listenWhen: (previous, current) => previous.dayType != current.dayType,
      listener: (context, state) {
        final offset = reverse == state.dayType.isWorkingDay
            ? _controller.position.maxScrollExtent
            : 0.0;
        _controller.animateTo(
          offset,
          duration: _scrollDuration,
          curve: _scrollCurve,
        );
      },
      child: BlocBuilder<DayTypeBloc, DayTypeState>(
        builder: (context, state) {
          final startDate = state.startDate;
          final endDate = state.endDate;
          return LayoutBuilder(
            builder: (context, constraints) {
              const defaultContentGap = 24;
              final double width = min(
                320,
                constraints.maxWidth -
                    (TalanAppDimensions.pageInsetGap + defaultContentGap) * 2,
              );
              return AlertDialog(
                insetPadding: EdgeInsets.all(TalanAppDimensions.pageInsetGap),
                title: const DayTypeSwitcherTitle(),
                content: DecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: TalanAppColors.n700,
                        width: .5,
                      ),
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: width,
                    ),
                    child: SizedBox(
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: SingleChildScrollView(
                          reverse: reverse,
                          controller: _controller,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  key: ValueKey(
                                    'dayTypeWorkingChild${state.dayType}',
                                  ),
                                  width: width,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: BlocProvider(
                                      create: (context) => EditWorkingDayBloc(
                                        day: day.runtimeType == WorkingDay
                                            ? day as WorkingDay
                                            : WorkingDay(
                                                day: day.day,
                                                month: day.month,
                                                year: day.year,
                                                startOne: _startTime,
                                                finishOne: _startTime,
                                                startTwo: _startTime,
                                                finishTwo: _startTime,
                                              ),
                                        isReadOnly: widget.onEditDate == null,
                                      ),
                                      child: EditWorkingDayView(
                                        onEditWorkingDate: (value) =>
                                            widget.onEditDate?.call(
                                          _buildScheduleList(
                                            startDate: startDate,
                                            endDate: endDate,
                                            scheduleDay: value,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  key: ValueKey(
                                    'dayTypeAbsenceChild${state.dayType}',
                                  ),
                                  width: width,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: BlocProvider(
                                      create: (context) => EditAbsenceDayBloc(
                                        day: day.runtimeType == AbsenceDay
                                            ? day as AbsenceDay
                                            : AbsenceDay(
                                                day: day.day,
                                                month: day.month,
                                                year: day.year,
                                                type: null,
                                              ),
                                        isReadOnly: widget.onEditDate == null,
                                      ),
                                      child: EditAbsenceDayView(
                                        onEditAbsenceDate: (value) =>
                                            widget.onEditDate?.call(
                                          _buildScheduleList(
                                            startDate: startDate,
                                            endDate: endDate,
                                            scheduleDay: value,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

const _startTime = '00:00';

List<ScheduleDay> _buildScheduleList({
  required DateTime startDate,
  required DateTime endDate,
  required ScheduleDay scheduleDay,
}) {
  final days = <ScheduleDay>[];
  final start = DateTime(
    startDate.year,
    startDate.month,
    startDate.day,
  );
  final end = DateTime(
    endDate.year,
    endDate.month,
    endDate.day,
  );
  for (var i = start; !i.isAfter(end); i = i.add(const Duration(days: 1))) {
    ScheduleDay? newDay;
    if (scheduleDay is WorkingDay) {
      newDay = scheduleDay.copyWith(
        day: i.day,
        month: i.month,
        year: i.year,
      );
    }
    if (scheduleDay is AbsenceDay) {
      newDay = scheduleDay.copyWith(
        day: i.day,
        month: i.month,
        year: i.year,
      );
    }
    days.add(newDay!);
  }
  return days;
}
