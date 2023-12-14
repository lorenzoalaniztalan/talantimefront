import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/bloc/day_type_bloc.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/bloc/edit_absence_day_bloc.dart';
import 'package:turnotron/app_views/master_data/master_data.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/widgets/input_controller_wrapper.dart';

class EditAbsenceDayView extends StatelessWidget {
  const EditAbsenceDayView({super.key, this.onEditAbsenceDate});
  final void Function(AbsenceDay day)? onEditAbsenceDate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocListener<EditAbsenceDayBloc, EditAbsenceDayState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == EditAbsenceDayStatus.done &&
            onEditAbsenceDate != null) {
          onEditAbsenceDate!(
            AbsenceDay(
              day: 0,
              month: 0,
              year: 0,
              type: state.type.value,
            ),
          );
        }
        if (state.status == EditAbsenceDayStatus.editing) {
          context.read<DayTypeBloc>().add(const DayTypeStartEditing());
        }
        if (state.status == EditAbsenceDayStatus.initial) {
          context.read<DayTypeBloc>().add(const DayTypeCancelEditing());
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(l10n.scheduleDayAbsenceDayDescription),
          spacerM,
          _AbsenceTypeInput(),
          spacerExpanded,
          const _Actions(),
        ],
      ),
    );
  }
}

class _AbsenceTypeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<EditAbsenceDayBloc, EditAbsenceDayState>(
      buildWhen: (previous, current) =>
          previous.type != current.type || previous.status != current.status,
      builder: (context, state) {
        final absenceTypes = context.read<MasterDataBloc>().state.absenceTypes;
        return InputControllerSpaceError(
          hasError: state.type.displayError != null,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            focusColor: Colors.transparent,
            key: const Key('registerForm_absencetypeInput_dropdownField'),
            value: state.type.value.id == -1 ? null : state.type.value.code,
            onChanged: state.status.canEdit
                ? (value) => context.read<EditAbsenceDayBloc>().add(
                      EditAbsenceDayTypeTimeChanged(
                        absenceTypes
                            .firstWhere((element) => element.code == value),
                      ),
                    )
                : null,
            decoration: InputDecoration(
              labelText: l10n.scheduleDayAbsenceTypeControllerLabel,
              errorText: state.type.displayError != null
                  ? l10n.scheduleDayAbsenceTypeControllerError
                  : null,
            ),
            items: List.generate(absenceTypes.length, (index) {
              final type = absenceTypes[index];
              return DropdownMenuItem(
                value: type.code,
                child: Text(type.name),
              );
            }),
          ),
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
    return BlocBuilder<EditAbsenceDayBloc, EditAbsenceDayState>(
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
        if (state.status == EditAbsenceDayStatus.initial) {
          children = [
            ElevatedButton(
              onPressed: () => context
                  .read<EditAbsenceDayBloc>()
                  .add(const EditAbsenceDayStartEditing()),
              child: Text(l10n.edit),
            )
          ];
        }
        if (state.status.canEdit) {
          children = [
            TextButton(
              onPressed: () => context
                  .read<EditAbsenceDayBloc>()
                  .add(const EditAbsenceDayCancelEditing()),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: state.isValid
                  ? () => context
                      .read<EditAbsenceDayBloc>()
                      .add(const EditAbsenceDaySubmitted())
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
