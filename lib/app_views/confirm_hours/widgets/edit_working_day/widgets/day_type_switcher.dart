import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/bloc/day_type_bloc.dart';
import 'package:turnotron/l10n/l10n.dart';

class DayTypeSwitcher extends StatelessWidget {
  const DayTypeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<DayTypeBloc, DayTypeState>(
      builder: (context, state) {
        if (state.status.isReadOnly) {
          return const SizedBox.shrink();
        }
        if (state.dayType.isWorkingDay) {
          return TextButton(
            style: Theme.of(context).textButtonTheme.style?.copyWith(
                  padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                ),
            onPressed: () => context.read<DayTypeBloc>().add(
                  const DayTypeSetAbsence(),
                ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.scheduleDaySwitcherButtonRegisterAbsenceDay,
                  style: const TextStyle(fontSize: 12),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 18,
                )
              ],
            ),
          );
        }
        return TextButton(
          style: Theme.of(context).textButtonTheme.style?.copyWith(
                padding: const MaterialStatePropertyAll(EdgeInsets.zero),
              ),
          onPressed: () => context.read<DayTypeBloc>().add(
                const DayTypeSetWorking(),
              ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.chevron_left,
                size: 18,
              ),
              Text(
                l10n.scheduleDaySwitcherButtonRegisterWorkingDay,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
