import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_repository/schedule_repository.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/home/widgets/sub_view_wrapper.dart';
import 'package:turnotron/app_views/regular_schedule_setup/bloc/regular_schedule_setup_bloc.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/utils/notifications.dart';
import 'package:turnotron/widgets/error_widget.dart';
import 'package:turnotron/widgets/input_controller_wrapper.dart';
import 'package:turnotron/widgets/time_of_day_input_controller.dart';

class RegularScheduleSetupPage extends StatelessWidget {
  const RegularScheduleSetupPage({
    required this.onBack,
    super.key,
  });
  final void Function() onBack;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegularScheduleSetupBloc(
        context.read<ScheduleRepository>(),
      )..add(
          const RegularScheduleSetupChecking(),
        ),
      child: _RegularScheduleSetupPageHandler(
        onBack: onBack,
      ),
    );
  }
}

class _RegularScheduleSetupPageHandler extends StatelessWidget {
  const _RegularScheduleSetupPageHandler({
    required this.onBack,
  });
  final void Function() onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return HomePageSubViewWrapper(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: onBack,
              label: Text(l10n.back),
              icon: const Icon(Icons.chevron_left),
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero),
              ),
            ),
          ),
          BlocListener<RegularScheduleSetupBloc, RegularScheduleSetupState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == RegularScheduleSetupStatus.checkingSuccess) {
                context
                    .read<RegularScheduleSetupBloc>()
                    .add(const RegularScheduleSetupCheckingSuccess());
              }
              if (state.status ==
                  RegularScheduleSetupStatus.submittingSuccess) {
                handleSuccess(l10n.usualScheduleSubmittedSuccessMessage);
                context
                    .read<RegularScheduleSetupBloc>()
                    .add(const RegularScheduleSetupCheckingSuccess());
              }
              if (state.status ==
                  RegularScheduleSetupStatus.submittingFailure) {
                handleError(l10n.usualScheduleSubmittedErrorMessage);
              }
            },
            child: BlocBuilder<RegularScheduleSetupBloc,
                RegularScheduleSetupState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                if (state.status ==
                    RegularScheduleSetupStatus.checkingFailure) {
                  return TalanErrorWidget(
                    message: l10n.usualSchedulePageCheckError,
                  );
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: state.status.isChecking
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : const _RegularScheduleSetupPage(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RegularScheduleSetupPage extends StatelessWidget {
  const _RegularScheduleSetupPage();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TalanText.headlineMedium(
          text: l10n.usualScheduleHoursTitle,
          style: TextStyle(
            color: Theme.of(context).textTheme.labelLarge?.color,
          ),
        ),
        spacerM,
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _CheckinTimeInput(),
                _BreakTimeInput(),
                const _BreakDuration(),
                _OneHourBreakChecker(),
                spacerS,
                _ReturnTimeInput(),
                _CheckoutTimeInput(),
                const _TotalHours(),
                _FulltimeChecker(),
                spacerL,
                const _Actions(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _CheckinTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RegularScheduleSetupBloc, RegularScheduleSetupState>(
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
                    .read<RegularScheduleSetupBloc>()
                    .add(RegularScheduleSetupCheckinTimeChanged(value)),
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
    return BlocBuilder<RegularScheduleSetupBloc, RegularScheduleSetupState>(
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
                    .read<RegularScheduleSetupBloc>()
                    .add(RegularScheduleSetupBreakTimeChanged(value)),
          ),
        );
      },
    );
  }
}

class _BreakDuration extends StatelessWidget {
  const _BreakDuration();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegularScheduleSetupBloc, RegularScheduleSetupState>(
      buildWhen: (previous, current) =>
          previous.oneHourBreakChecker != current.oneHourBreakChecker,
      builder: (context, state) {
        final l10n = AppLocalizations.of(context);
        final duration = state.oneHourBreakChecker;
        final color = duration.displayError == null
            ? TalanAppColors.success
            : TalanAppColors.error;
        final hours = duration.hours;
        final minutes = duration.minutes;
        return TalanText.headlineSmall(
          text:
              '${l10n.usualScheduleOneHourBreakLabel}: ${hours}h${minutes == 0 ? '' : (' ${minutes}m')}',
          textAlign: TextAlign.end,
          style: TextStyle(color: color),
        );
      },
    );
  }
}

class _OneHourBreakChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RegularScheduleSetupBloc, RegularScheduleSetupState>(
      buildWhen: (previous, current) =>
          previous.oneHourBreakChecker != current.oneHourBreakChecker,
      builder: (context, state) {
        final text = state.oneHourBreakChecker.displayError != null
            ? l10n.usualScheduleOneHourBreakError
            : '';
        return TalanText.bodySmall(
          text: text,
          style: (Theme.of(context).inputDecorationTheme.errorStyle ??
                  const TextStyle())
              .copyWith(color: TalanAppColors.error),
        );
      },
    );
  }
}

class _ReturnTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RegularScheduleSetupBloc, RegularScheduleSetupState>(
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
                    .read<RegularScheduleSetupBloc>()
                    .add(RegularScheduleSetupReturnTimeChanged(value)),
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
    return BlocBuilder<RegularScheduleSetupBloc, RegularScheduleSetupState>(
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
                    .read<RegularScheduleSetupBloc>()
                    .add(RegularScheduleSetupCheckoutTimeChanged(value)),
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
    return BlocBuilder<RegularScheduleSetupBloc, RegularScheduleSetupState>(
      buildWhen: (previous, current) =>
          previous.fulltimeChecker != current.fulltimeChecker,
      builder: (context, state) {
        final text = state.fulltimeChecker.displayError != null
            ? l10n.usualScheduleFullTimeError
            : '';
        return TalanText.bodySmall(
          text: text,
          style: (Theme.of(context).inputDecorationTheme.errorStyle ??
                  const TextStyle())
              .copyWith(color: TalanAppColors.error),
        );
      },
    );
  }
}

class _TotalHours extends StatelessWidget {
  const _TotalHours();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegularScheduleSetupBloc, RegularScheduleSetupState>(
      buildWhen: (previous, current) =>
          previous.fulltimeChecker != current.fulltimeChecker,
      builder: (context, state) {
        final l10n = AppLocalizations.of(context);
        final duration =
            context.read<RegularScheduleSetupBloc>().state.fulltimeChecker;
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
    return BlocBuilder<RegularScheduleSetupBloc, RegularScheduleSetupState>(
      builder: (context, state) {
        var children = <Widget>[];
        if (state.status == RegularScheduleSetupStatus.initial) {
          children = [
            ElevatedButton(
              onPressed: () => context
                  .read<RegularScheduleSetupBloc>()
                  .add(const RegularScheduleSetupStartEditing()),
              child: Text(l10n.edit),
            )
          ];
        }
        if (state.status == RegularScheduleSetupStatus.submitting) {
          children = [
            const Expanded(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          ];
        }
        if (state.status.canEdit) {
          children = [
            TextButton(
              onPressed: () => context
                  .read<RegularScheduleSetupBloc>()
                  .add(const RegularScheduleSetupCancelEditing()),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: state.isValid
                  ? () => context
                      .read<RegularScheduleSetupBloc>()
                      .add(const RegularScheduleSetupSubmitted())
                  : null,
              child: Text(l10n.save),
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
