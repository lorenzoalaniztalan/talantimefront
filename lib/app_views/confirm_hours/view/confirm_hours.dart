import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:schedule_repository/schedule_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/authentication/authentication.dart';
import 'package:turnotron/app_views/confirm_hours/bloc/confirm_hours_bloc.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/confirm_calendar_navigation.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/current_month_texts_confirmed.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/current_month_texts_draft.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/day_modal_orchester.dart';
import 'package:turnotron/app_views/home/widgets/sub_view_wrapper.dart';
import 'package:turnotron/app_views/providers/locale_provider.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/utils/notifications.dart';
import 'package:turnotron/utils/time_utils.dart';
import 'package:turnotron/widgets/calendar_day.dart';
import 'package:turnotron/widgets/error_widget.dart';

class ConfirmHoursPage extends StatelessWidget {
  const ConfirmHoursPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    return BlocProvider(
      create: (context) => ConfirmHoursBloc(
        scheduleRepository: context.read<ScheduleRepository>(),
        userId: user.id,
        firstAvailableDate: user.creationDate,
      )..add(const ConfirmHoursFirstRefresh()),
      child: const ConfirmHoursView(),
    );
  }
}

class ConfirmHoursView extends StatelessWidget {
  const ConfirmHoursView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET);
    return HomePageSubViewWrapper(
      child: BlocListener<ConfirmHoursBloc, ConfirmHoursState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == ConfirmHoursStatus.success) {
            handleSuccess(l10n.scheduleConfirmedSuccessMessage);
          }
          if (state.status == ConfirmHoursStatus.failure) {
            handleError(l10n.scheduleConfirmedErrorMessage);
          }
        },
        child: BlocBuilder<ConfirmHoursBloc, ConfirmHoursState>(
          builder: (context, state) {
            if (state.status == ConfirmHoursStatus.failure) {
              return Center(
                child: TalanErrorWidget(
                  message: l10n.scheduleConfirmedHoursServerError,
                ),
              );
            }
            final currentDate = state.currentDate;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TopAlert(),
                Flex(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _UnconfirmedMonths(),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              child: state.status.isLoading
                                  ? const SizedBox.shrink()
                                  : (state.monthScheduleStatus.isConfirmed)
                                      ? CurrentMonthTextsConfirmed(
                                          today: currentDate,
                                        )
                                      : CurrentMonthTextsDraft(
                                          today: currentDate,
                                        ),
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
                                    pageAnimationEnabled: false,
                                    pageAnimationDuration:
                                        const Duration(milliseconds: 1),
                                    locale: Provider.of<LocaleProvider>(context)
                                        .locale
                                        .toString(),
                                    startingDayOfWeek: StartingDayOfWeek.monday,
                                    calendarStyle: const CalendarStyle(
                                      isTodayHighlighted: false,
                                    ),
                                    firstDay: state.firstAvailableDate,
                                    lastDay: currentDate.copyWith(
                                      year: currentDate.year + 1,
                                    ),
                                    focusedDay: currentDate,
                                    availableCalendarFormats: const {
                                      CalendarFormat.month: 'Month'
                                    },
                                    sixWeekMonthsEnforced: true,
                                    onHeaderTapped: (focusedDayArg) async {
                                      final res = await showDatePicker(
                                        context: context,
                                        initialDate: currentDate,
                                        firstDate: state.firstAvailableDate,
                                        lastDate: DateTime.now(),
                                      );
                                      if (res != null) {
                                        context.read<ConfirmHoursBloc>().add(
                                              ConfirmHoursRefresh(
                                                date: res,
                                              ),
                                            );
                                      }
                                    },
                                    onPageChanged: (focusedDay) async {
                                      if (areSameMonthAndYear(
                                        focusedDay,
                                        currentDate,
                                      )) {
                                        return;
                                      }
                                      var shouldNavigate = true;
                                      if (state.dataStatus.isEditing) {
                                        shouldNavigate = await showDialog<bool>(
                                              context: context,
                                              builder: (context) =>
                                                  const ConfirmCalendarNavigation(),
                                            ) ??
                                            false;
                                      }
                                      if (shouldNavigate) {
                                        context.read<ConfirmHoursBloc>().add(
                                              ConfirmHoursRefresh(
                                                date: focusedDay,
                                              ),
                                            );
                                      } else {
                                        context.read<ConfirmHoursBloc>().add(
                                              const ConfirmHoursCancelNavigation(),
                                            );
                                      }
                                    },
                                    headerStyle: HeaderStyle(
                                      headerPadding: (areSameMonthAndYear(
                                                currentDate,
                                                state.firstAvailableDate,
                                              ) &&
                                              areSameMonthAndYear(
                                                currentDate,
                                                DateTime.now(),
                                              ))
                                          ? const EdgeInsets.symmetric(
                                              horizontal: 35,
                                              vertical: 21.5,
                                            )
                                          : const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ).copyWith(
                                              left: areSameMonthAndYear(
                                                state.firstAvailableDate,
                                                currentDate,
                                              )
                                                  ? 35
                                                  : 0,
                                            ),
                                      leftChevronVisible: !areSameMonthAndYear(
                                        state.firstAvailableDate,
                                        currentDate,
                                      ),
                                      rightChevronVisible: !areSameMonthAndYear(
                                        DateTime.now(),
                                        currentDate,
                                      ),
                                      headerMargin:
                                          const EdgeInsets.only(bottom: 20),
                                      decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide()),
                                      ),
                                    ),
                                    calendarBuilders:
                                        CalendarBuilders<CalendarDay>(
                                      defaultBuilder:
                                          (context, day, focusedDay) =>
                                              TalanTouchable(
                                        onPress: (areSameMonthAndYear(
                                                  day,
                                                  currentDate,
                                                ) &&
                                                !state.status.isLoading &&
                                                state.monthSchedule?[day.day] !=
                                                    null &&
                                                state.monthSchedule![day.day]
                                                        ?.confirmed ==
                                                    false)
                                            ? () {
                                                showDialog<void>(
                                                  context: context,
                                                  builder: (_) =>
                                                      ScheduleDayOrchester(
                                                    day: state.monthSchedule![
                                                        day.day]!,
                                                    onEditDate: state
                                                            .monthScheduleStatus
                                                            .isConfirmed
                                                        ? null
                                                        : (value) {
                                                            context
                                                                .read<
                                                                    ConfirmHoursBloc>()
                                                                .add(
                                                                  ConfirmHoursEditedDay(
                                                                    days: value,
                                                                  ),
                                                                );
                                                          },
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
                                              : state.monthSchedule?[day.day],
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
                            maintainState: true,
                            maintainSize: true,
                            maintainAnimation: true,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TalanText.headlineMedium(
                                  text:
                                      '${l10n.scheduleConfirmTotalHoursLabel}:',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.color,
                                  ),
                                ),
                                spacerXs,
                                TalanText.headlineMedium(
                                  text:
                                      '${(state.monthSchedule?.values.where((element) => element.confirmed != null && element.confirmed!).length ?? 0) * 8}h',
                                  style: const TextStyle(
                                    color: TalanAppColors.success,
                                  ),
                                )
                              ],
                            ),
                          ),
                          spacerM,
                          const _CallToActionButton(),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TopAlert extends StatelessWidget {
  const _TopAlert();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmHoursBloc, ConfirmHoursState>(
      builder: (context, state) {
        if (state.unconfirmedMonths.isEmpty) {
          return const SizedBox.shrink();
        }
        final l10n = AppLocalizations.of(context);

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: TalanAppColors.error.withOpacity(0.3),
              borderRadius: BorderRadius.circular(
                TalanAppDimensions.borderRadiusControllers,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.warning, color: TalanAppColors.error),
                  TalanText.bodyLarge(
                    text: l10n.scheduleUnconfirmedPreviousMonthsAlert,
                    // style: const TextStyle(color: TalanAppColors.light),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _UnconfirmedMonths extends StatelessWidget {
  const _UnconfirmedMonths();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmHoursBloc, ConfirmHoursState>(
      builder: (context, state) {
        if (state.unconfirmedMonths.isEmpty) {
          return const SizedBox.shrink();
        }
        final l10n = AppLocalizations.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TalanText.headlineMedium(
              text: l10n.scheduleUnconfirmedPreviousMonthsTitle,
              style: TextStyle(
                color: Theme.of(context).textTheme.labelLarge?.color,
              ),
            ),
            spacerM,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: state.unconfirmedMonths.map(
                (e) {
                  final date = DateTime(e.year, e.month);
                  const color = TalanAppColors.error;
                  return ChoiceChip(
                    selectedColor: color,
                    backgroundColor: color.withOpacity(0.3),
                    label: Text(
                      DateFormat.yMMM(
                        Provider.of<LocaleProvider>(context).locale.toString(),
                      ).format(date),
                    ),
                    onSelected: (_) => context.read<ConfirmHoursBloc>().add(
                          ConfirmHoursRefresh(
                            date: date,
                          ),
                        ),
                    selected: areSameMonthAndYear(
                      DateTime(e.year, e.month),
                      state.currentDate,
                    ),
                  );
                },
              ).toList(),
            ),
            spacerL,
          ],
        );
      },
    );
  }
}

class _CallToActionButton extends StatelessWidget {
  const _CallToActionButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ConfirmHoursBloc, ConfirmHoursState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Visibility.maintain(
          visible: !state.status.isLoading &&
              (state.monthScheduleStatus.isDraft ||
                  state.monthScheduleStatus.isConfirmed),
          child: Builder(
            builder: (context) {
              if (state.monthScheduleStatus.isConfirmed) {
                return TalanText.headlineMedium(
                  text: l10n.scheduleConfirmedHoursButton,
                  style: const TextStyle(color: TalanAppColors.success),
                );
              }
              // if (state.monthScheduleStatus.isConfirmed) {
              //   return OutlinedButton(
              //     onPressed: state.status.isLoading
              //         ? null
              //         : () async {
              //             final res = await showDialog<bool?>(
              //               context: context,
              //               builder: (dialogContext) =>
              //                   _DeleteConfirmedMonthConfirmationModal(
              //                 date: state.currentDate,
              //               ),
              //             );
              //             if (res == true) {
              //               context.read<ConfirmHoursBloc>().add(
              //                     ConfirmHoursDeleteRequestSubmitted(
              //                       userId: context
              //                           .read<AuthenticationBloc>()
              //                           .state
              //                           .user
              //                           .id,
              //                     ),
              //                   );
              //             }
              //           },
              //     child: Text(l10n.scheduleDeleteScheduleButton),
              //   );
              // }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}

class _DeleteConfirmedMonthConfirmationModal extends StatelessWidget {
  const _DeleteConfirmedMonthConfirmationModal({
    required this.date,
  });
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(
        l10n.scheduleDeleteScheduleModalTitle,
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${l10n.scheduleDeleteScheduleModalSubtitleOne} ${DateFormat.yMMMM().format(date)}.',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.scheduleDeleteScheduleButton),
        ),
      ],
    );
  }
}
