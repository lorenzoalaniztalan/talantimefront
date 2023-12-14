import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/bloc/day_type_bloc.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/widgets/day_type_switcher.dart';
import 'package:turnotron/app_views/providers/locale_provider.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/utils/time_utils.dart';

class DayTypeSwitcherTitle extends StatelessWidget {
  const DayTypeSwitcherTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)
        ? const _DayTypeSwitcherTitleMobile()
        : const _DayTypeSwitcherTitleDeskTop();
  }
}

class _DayTypeSwitcherTitleDeskTop extends StatelessWidget {
  const _DayTypeSwitcherTitleDeskTop();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _DayTypeTitleDates(),
        ),
        DayTypeSwitcher()
      ],
    );
  }
}

class _DayTypeSwitcherTitleMobile extends StatelessWidget {
  const _DayTypeSwitcherTitleMobile();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        DayTypeSwitcher(),
        Align(
          alignment: Alignment.centerLeft,
          child: _DayTypeTitleDates(),
        ),
      ],
    );
  }
}

class _DayTypeTitleDates extends StatelessWidget {
  const _DayTypeTitleDates();

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context).locale.toString();
    return BlocBuilder<DayTypeBloc, DayTypeState>(
      builder: (context, state) {
        final startDate = state.startDate;
        final endDate = state.endDate;
        if (state.status.isReadOnly) {
          return TalanText.headlineSmall(
            text: DateFormat.yMMMd(locale).format(
              startDate,
            ),
          );
        }
        final l10n = AppLocalizations.of(context);
        return Padding(
          padding: EdgeInsets.zero,
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TalanText.bodyMedium(
                      text: l10n.from,
                    ),
                    spacerXs,
                    TalanText.bodyMedium(
                      text: l10n.to,
                    ),
                  ],
                ),
                spacerXs,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _DateDecoration(
                      child: TalanText.headlineSmall(
                        text: DateFormat.yMMMd(locale).format(
                          startDate,
                        ),
                      ),
                    ),
                    spacerXs,
                    TalanTouchable(
                      onPress: state.status.canEdit
                          ? () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: endDate,
                                firstDate: startDate,
                                lastDate: lastDayOfMonth(startDate),
                              );
                              if (date != null) {
                                context.read<DayTypeBloc>().add(
                                      DayTypeSetEndDate(
                                        date: date,
                                      ),
                                    );
                              }
                            }
                          : null,
                      child: _DateDecoration(
                        shouldHighlight: state.status.canEdit,
                        child: TalanText.headlineSmall(
                          text: DateFormat.yMMMd(locale).format(
                            endDate,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DateDecoration extends StatelessWidget {
  const _DateDecoration({
    required this.child,
    this.shouldHighlight = false,
  });
  final Widget child;
  final bool shouldHighlight;

  @override
  Widget build(BuildContext context) {
    final highlightColor = Theme.of(context).primaryColor;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: shouldHighlight ? highlightColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
            Visibility.maintain(
              visible: shouldHighlight,
              child: Icon(
                Icons.arrow_drop_down,
                color: highlightColor,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
