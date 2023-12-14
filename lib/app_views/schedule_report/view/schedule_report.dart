import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:schedule_repository/schedule_repository.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/master_data/master_data.dart';
import 'package:turnotron/app_views/providers/locale_provider.dart';
import 'package:turnotron/app_views/schedule_report/bloc/schedule_report_bloc.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/utils/static_data.dart';
import 'package:turnotron/widgets/multi_select.dart';

class ScheduleReportView extends StatelessWidget {
  const ScheduleReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleReportBloc(
        context.read<ScheduleRepository>(),
      ),
      child: const _ScheduleView(),
    );
  }
}

class _ScheduleView extends StatelessWidget {
  const _ScheduleView();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350, minWidth: 350),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _RangeDateField(),
          spacerM,
          _OfficelistField(),
          spacerM,
          Row(
            children: [
              Expanded(child: _UserlistField()),
              spacerXs,
              _AllUsers(),
            ],
          ),
          spacerL,
          _Actions(),
        ],
      ),
    );
  }
}

class _RangeDateField extends StatelessWidget {
  const _RangeDateField();

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context).locale.toString();
    return BlocBuilder<ScheduleReportBloc, ScheduleReportState>(
      buildWhen: (previous, current) =>
          previous.startDate != current.startDate ||
          previous.endDate != current.endDate,
      builder: (context, state) {
        return OutlinedButton.icon(
          onPressed: () async {
            final res = await showCalendarDatePicker2Dialog(
              context: context,
              value: [state.startDate.value, state.endDate.value],
              dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
              config: CalendarDatePicker2WithActionButtonsConfig(
                calendarType: CalendarDatePicker2Type.range,
                firstDate: firstDayForCalendars,
                currentDate: DateTime.now(),
                firstDayOfWeek: 1,
                selectedRangeHighlightColor:
                    TalanAppColors.primary.withOpacity(0.5),
                selectedDayHighlightColor: TalanAppColors.primary,
              ),
              dialogSize: const Size(325, 400),
            );
            if (res != null) {
              context.read<ScheduleReportBloc>().add(
                    RangeDateChanged(
                      rangeDate: DateTimeRange(start: res[0]!, end: res[1]!),
                    ),
                  );
            }
          },
          icon: const Icon(Icons.calendar_today),
          label: Text(
            '${DateFormat.yMMMd(locale).format(state.startDate.value)} - ${DateFormat.yMMMd(locale).format(state.endDate.value)}',
          ),
        );
      },
    );
  }
}

class _OfficelistField extends StatelessWidget {
  const _OfficelistField();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ScheduleReportBloc, ScheduleReportState>(
      buildWhen: (previous, current) =>
          previous.officelist != current.officelist,
      builder: (context, state) {
        final allOffices = context.read<MasterDataBloc>().state.offices;
        return MultiSelect(
          hint: '',
          label: l10n.inputControllerOfficeLabel,
          onChanged: (values) {
            context.read<ScheduleReportBloc>().add(
                  OfficelistChanged(
                    values!.map((e) => e as String).toList(),
                  ),
                );
          },
          required: true,
          options:
              allOffices.map((e) => MultiSelectItem(e.code, e.name)).toList(),
          values: state.officelist.value,
        );
      },
    );
  }
}

class _UserlistField extends StatelessWidget {
  const _UserlistField();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ScheduleReportBloc, ScheduleReportState>(
      buildWhen: (previous, current) =>
          previous.userlist != current.userlist ||
          previous.officelist != current.officelist,
      builder: (context, state) {
        final allUsers = context.read<MasterDataBloc>().state.users;
        final filteredUsers = allUsers
            .where(
              (user) =>
                  state.officelist.value.isEmpty ||
                  state.officelist.value.contains(user.officeCode),
            )
            .toList();
        final filteredUsersIds = filteredUsers.map((e) => e.id).toList();
        final selectedUsers = state.userlist.value
            .where(
              filteredUsersIds.contains,
            )
            .toList();
        return MultiSelect(
          hint: '',
          label: l10n.users,
          onChanged: (values) {
            context.read<ScheduleReportBloc>().add(
                  UserlistChanged(
                    values!.map((e) => e as int).toList(),
                  ),
                );
          },
          required: true,
          options: filteredUsers
              .map((e) => MultiSelectItem(e.id, e.toString()))
              .toList(),
          values: selectedUsers,
        );
      },
    );
  }
}

class _AllUsers extends StatelessWidget {
  const _AllUsers();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ScheduleReportBloc, ScheduleReportState>(
      builder: (context, state) {
        final allUsers = context.read<MasterDataBloc>().state.users;
        final filteredUsers = allUsers
            .where(
              (user) =>
                  state.officelist.value.isEmpty ||
                  state.officelist.value.contains(user.officeCode),
            )
            .toList();
        final filteredUsersIds = filteredUsers.map((e) => e.id).toList();
        final selectedUsers = state.userlist.value
            .where(
              filteredUsersIds.contains,
            )
            .toList();
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox.adaptive(
              value: selectedUsers.isNotEmpty &&
                  filteredUsersIds.length == selectedUsers.length,
              onChanged: (value) {
                context.read<ScheduleReportBloc>().add(
                      UserlistChanged(
                        value! ? filteredUsersIds : const <int>[],
                      ),
                    );
              },
              visualDensity: VisualDensity.compact,
            ),
            spacerXs,
            Text(l10n.selectAll)
          ],
        );
      },
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ScheduleReportBloc, ScheduleReportState>(
      builder: (context, state) {
        final children = <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: state.isValid
                ? () => context
                    .read<ScheduleReportBloc>()
                    .add(const ScheduleReportSubmitted())
                : null,
            child: Text(l10n.download),
          )
        ];
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: children,
        );
      },
    );
  }
}
