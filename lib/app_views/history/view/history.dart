import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:schedule_repository/schedule_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/authentication/authentication.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/day_modal_orchester.dart';
import 'package:turnotron/app_views/history/bloc/history_schedule_bloc.dart';
import 'package:turnotron/app_views/home/widgets/sub_view_wrapper.dart';
import 'package:turnotron/app_views/providers/locale_provider.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/utils/notifications.dart';
import 'package:turnotron/utils/static_data.dart';
import 'package:turnotron/utils/time_utils.dart';
import 'package:turnotron/widgets/calendar_day.dart';

class HistorySchedulePage extends StatelessWidget {
  const HistorySchedulePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryScheduleBloc(
        scheduleRepository: context.read<ScheduleRepository>(),
      )..add(
          HistoryScheduleChangeFocusedDay(
            focusedDay: DateTime.now(),
            userId: context.read<AuthenticationBloc>().state.user.id,
          ),
        ),
      child: const HistoryScheduleView(),
    );
  }
}

class HistoryScheduleView extends StatelessWidget {
  const HistoryScheduleView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET);
    return HomePageSubViewWrapper(
      child: BlocListener<HistoryScheduleBloc, HistoryScheduleState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state.status == HistoryScheduleStatus.failure) {
            handleError(l10n.defaultServerError);
          }
        },
        child: BlocBuilder<HistoryScheduleBloc, HistoryScheduleState>(
          builder: (context, state) {
            final currentDate = state.focusedDay;
            return Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isMobile ? 0 : 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TalanText.headlineMedium(
                          text: l10n.historyPageTitle,
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelLarge?.color,
                          ),
                        ),
                        spacerM,
                        TalanText.bodyLarge(
                          text: l10n.historyPageSubtitleOne,
                        ),
                        spacerM,
                        TalanText.bodyMedium(
                          text: ' - ${l10n.scheduleConfirmedHoursSubtitleTwo}.',
                        ),
                      ],
                    ),
                  ),
                ),
                spacerL,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Opacity(
                              opacity: state.status.isLoading ? 0.4 : 1,
                              child: TableCalendar(
                                locale: Provider.of<LocaleProvider>(context)
                                    .locale
                                    .toString(),
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                calendarStyle: const CalendarStyle(
                                  isTodayHighlighted: false,
                                ),
                                firstDay: firstDayForCalendars,
                                lastDay: DateTime.now(),
                                focusedDay: currentDate,
                                availableCalendarFormats: const {
                                  CalendarFormat.month: 'Month'
                                },
                                sixWeekMonthsEnforced: true,
                                onPageChanged: (focusedDay) {
                                  context.read<HistoryScheduleBloc>().add(
                                        HistoryScheduleChangeFocusedDay(
                                          focusedDay: focusedDay,
                                          userId: context
                                              .read<AuthenticationBloc>()
                                              .state
                                              .user
                                              .id,
                                        ),
                                      );
                                },
                                onHeaderTapped: (focusedDayArg) async {
                                  final res = await showDatePicker(
                                    context: context,
                                    initialDate: currentDate,
                                    firstDate: firstDayForCalendars,
                                    lastDate: DateTime.now(),
                                  );
                                  if (res != null) {
                                    context.read<HistoryScheduleBloc>().add(
                                          HistoryScheduleChangeFocusedDay(
                                            focusedDay: res,
                                            userId: context
                                                .read<AuthenticationBloc>()
                                                .state
                                                .user
                                                .id,
                                          ),
                                        );
                                  }
                                },
                                headerStyle: HeaderStyle(
                                  headerPadding: (areSameMonthAndYear(
                                            context
                                                .read<AuthenticationBloc>()
                                                .state
                                                .user
                                                .creationDate,
                                            currentDate,
                                          ) &&
                                          areSameMonthAndYear(
                                            currentDate,
                                            DateTime.now(),
                                          ))
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 35,
                                          vertical: 21.5,
                                        )
                                      : const EdgeInsets.symmetric(vertical: 8)
                                          .copyWith(
                                          left: areSameMonthAndYear(
                                            context
                                                .read<AuthenticationBloc>()
                                                .state
                                                .user
                                                .creationDate,
                                            currentDate,
                                          )
                                              ? 35
                                              : 0,
                                        ),
                                  headerMargin:
                                      const EdgeInsets.only(bottom: 20),
                                  decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide()),
                                  ),
                                  leftChevronVisible: !areSameMonthAndYear(
                                    context
                                        .read<AuthenticationBloc>()
                                        .state
                                        .user
                                        .creationDate,
                                    currentDate,
                                  ),
                                  rightChevronVisible: !areSameMonthAndYear(
                                    DateTime.now(),
                                    currentDate,
                                  ),
                                ),
                                calendarBuilders: CalendarBuilders<CalendarDay>(
                                  defaultBuilder: (context, day, focusedDay) =>
                                      TalanTouchable(
                                    onPress: (areSameMonthAndYear(
                                              day,
                                              currentDate,
                                            ) &&
                                            !state.status.isLoading &&
                                            state.monthSchedule[day.day] !=
                                                null)
                                        ? () {
                                            showDialog<void>(
                                              context: context,
                                              builder: (_) =>
                                                  ScheduleDayOrchester(
                                                day: state
                                                    .monthSchedule[day.day]!,
                                              ),
                                            );
                                          }
                                        : null,
                                    child: CalendarDay(
                                      day: day,
                                      scheduleDay: (!areSameMonthAndYear(
                                                focusedDay,
                                                currentDate,
                                              ) ||
                                              state.status.isLoading)
                                          ? null
                                          : state.monthSchedule[day.day],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            spacerM
                          ],
                        ),
                      ),
                      spacerM,
                      Visibility(
                        visible: !state.status.isLoading,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TalanText.headlineMedium(
                              text: '${l10n.scheduleConfirmTotalHoursLabel}:',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.color,
                              ),
                            ),
                            spacerXs,
                            TalanText.headlineMedium(
                              text: '${state.monthSchedule.values.length * 8}h',
                              style: const TextStyle(
                                color: TalanAppColors.success,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
