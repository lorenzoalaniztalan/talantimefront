import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_schedule_api/http_schedule_api.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/bloc/day_type_bloc.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/bloc/edit_working_day_bloc.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/widgets/input_controller_wrapper.dart';
import 'package:turnotron/widgets/time_of_day_input_controller.dart';

class EditWorkingDayView extends StatelessWidget {
  const EditWorkingDayView({super.key, this.onEditWorkingDate});
  final void Function(WorkingDay day)? onEditWorkingDate;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditWorkingDayBloc, EditWorkingDayState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == EditWorkingDayStatus.done &&
            onEditWorkingDate != null) {
          onEditWorkingDate!(
            WorkingDay(
              day: 0,
              month: 0,
              year: 0,
              startOne:
                  TimeOfDaySerializable.fromTimeOfDay(state.checkinTime.value)
                      .toString(),
              finishOne:
                  TimeOfDaySerializable.fromTimeOfDay(state.breakTime.value)
                      .toString(),
              startTwo:
                  TimeOfDaySerializable.fromTimeOfDay(state.returnTime.value)
                      .toString(),
              finishTwo:
                  TimeOfDaySerializable.fromTimeOfDay(state.checkoutTime.value)
                      .toString(),
            ),
          );
        }
        if (state.status == EditWorkingDayStatus.editing) {
          context.read<DayTypeBloc>().add(const DayTypeStartEditing());
        }
        if (state.status == EditWorkingDayStatus.initial) {
          context.read<DayTypeBloc>().add(const DayTypeCancelEditing());
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _CheckinTimeInput(),
          _BreakTimeInput(),
          _ReturnTimeInput(),
          _CheckoutTimeInput(),
          const _TotalHours(),
          spacerS,
          _FulltimeChecker(),
          spacerM,
          const _Actions(),
        ],
      ),
    );
  }
}

class _CheckinTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<EditWorkingDayBloc, EditWorkingDayState>(
      buildWhen: (previous, current) =>
          previous.checkinTime != current.checkinTime ||
          previous.status != current.status,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.checkinTime.displayError != null,
          child: TimeOfDayFormField(
            label: l10n.scheduleCheckIn,
            key: Key(
              'scheduleFormCheckinInput_textField${state.checkinTime.hashCode}',
            ),
            initialValue: state.checkinTime.value,
            displayError: state.checkinTime.displayError == null
                ? null
                : l10n.usualScheduleCheckinTimeError,
            onChanged: !state.status.canEdit
                ? null
                : (value) => context
                    .read<EditWorkingDayBloc>()
                    .add(EditWorkingDayCheckinTimeChanged(value)),
          ),
        );
      },
    );
  }
}

class _BreakTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<EditWorkingDayBloc, EditWorkingDayState>(
      buildWhen: (previous, current) =>
          previous.breakTime != current.breakTime ||
          previous.checkinTime != current.checkinTime ||
          previous.status != current.status,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.breakTime.displayError != null,
          child: TimeOfDayFormField(
            label: l10n.scheduleRestStart,
            key: Key(
              'scheduleFormBreakInput_textField${state.breakTime.hashCode}',
            ),
            initialValue: state.breakTime.value,
            displayError: state.breakTime.displayError == null
                ? null
                : l10n.usualScheduleBreakTimeError,
            onChanged: !state.status.canEdit
                ? null
                : (value) => context
                    .read<EditWorkingDayBloc>()
                    .add(EditWorkingDayBreakTimeChanged(value)),
          ),
        );
      },
    );
  }
}

class _ReturnTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<EditWorkingDayBloc, EditWorkingDayState>(
      buildWhen: (previous, current) =>
          previous.returnTime != current.returnTime ||
          previous.breakTime != current.breakTime ||
          previous.status != current.status,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.returnTime.displayError != null,
          child: TimeOfDayFormField(
            label: l10n.scheduleRestEnd,
            key: Key(
              'scheduleFormReturnInput_textField${state.returnTime.hashCode}',
            ),
            initialValue: state.returnTime.value,
            displayError: state.returnTime.displayError == null
                ? null
                : l10n.usualScheduleReturnTimeError,
            onChanged: !state.status.canEdit
                ? null
                : (value) => context
                    .read<EditWorkingDayBloc>()
                    .add(EditWorkingDayReturnTimeChanged(value)),
          ),
        );
      },
    );
  }
}

class _CheckoutTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<EditWorkingDayBloc, EditWorkingDayState>(
      buildWhen: (previous, current) =>
          previous.checkoutTime != current.checkoutTime ||
          previous.returnTime != current.returnTime ||
          previous.status != current.status,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.checkoutTime.displayError != null,
          child: TimeOfDayFormField(
            label: l10n.scheduleCheckOut,
            key: Key(
              'scheduleForCheckoutInputtextField${state.checkoutTime.hashCode}',
            ),
            initialValue: state.checkoutTime.value,
            displayError: state.checkoutTime.displayError == null
                ? null
                : l10n.usualScheduleCheckoutTimeError,
            onChanged: !state.status.canEdit
                ? null
                : (value) => context
                    .read<EditWorkingDayBloc>()
                    .add(EditWorkingDayCheckoutTimeChanged(value)),
          ),
        );
      },
    );
  }
}

class _FulltimeChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<EditWorkingDayBloc, EditWorkingDayState>(
      buildWhen: (previous, current) =>
          previous.fulltimeChecker != current.fulltimeChecker,
      builder: (context, state) {
        final text = state.fulltimeChecker.displayError != null
            ? l10n.usualScheduleFullTimeError
            : '';
        return SizedBox(
          width: 280,
          child: TalanText.bodySmall(
            text: text,
            style: (Theme.of(context).inputDecorationTheme.errorStyle ??
                    const TextStyle())
                .copyWith(color: TalanAppColors.error),
          ),
        );
      },
    );
  }
}

class _TotalHours extends StatelessWidget {
  const _TotalHours();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditWorkingDayBloc, EditWorkingDayState>(
      buildWhen: (previous, current) =>
          previous.fulltimeChecker != current.fulltimeChecker,
      builder: (context, state) {
        final l10n = AppLocalizations.of(context);
        final duration =
            context.read<EditWorkingDayBloc>().state.fulltimeChecker;
        final color = duration.displayError == null
            ? TalanAppColors.success
            : TalanAppColors.error;
        final hours = duration.hours;
        final minutes = duration.minutes;
        return TalanText.headlineSmall(
          text:
              '${l10n.scheduleConfirmTotalHoursLabel}: ${hours}h${minutes == 0 ? '' : (' ${minutes}m')}',
          textAlign: TextAlign.end,
          style: TextStyle(color: color),
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
    return BlocBuilder<EditWorkingDayBloc, EditWorkingDayState>(
      builder: (context, state) {
        var children = <Widget>[];
        if (state.status.isReadOnly) {
          children = [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(l10n.ok),
            )
          ];
        }
        if (state.status == EditWorkingDayStatus.initial) {
          children = [
            ElevatedButton(
              onPressed: () => context
                  .read<EditWorkingDayBloc>()
                  .add(const EditWorkingDayStartEditing()),
              child: Text(l10n.edit),
            )
          ];
        }
        if (state.status.canEdit) {
          children = [
            TextButton(
              onPressed: () => context
                  .read<EditWorkingDayBloc>()
                  .add(const EditWorkingDayCancelEditing()),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: state.isValid
                  ? () => context
                      .read<EditWorkingDayBloc>()
                      .add(const EditWorkingDaySubmitted())
                  : null,
              child: Text(l10n.clockIn),
            )
          ];
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: children,
        );
      },
    );
  }
}
