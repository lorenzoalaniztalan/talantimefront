import 'package:absence_api/absence_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:turnotron/app_views/confirm_hours/widgets/edit_working_day/model/absence.dart';

part 'edit_absence_day_event.dart';
part 'edit_absence_day_state.dart';

class EditAbsenceDayBloc
    extends Bloc<EditAbsenceDayEvent, EditAbsenceDayState> {
  EditAbsenceDayBloc({
    required AbsenceDay day,
    required bool isReadOnly,
  }) : super(
          EditAbsenceDayState(
            initialType:
                day.type ?? const AbsenceType(id: -1, name: '', code: ''),
            status: isReadOnly
                ? EditAbsenceDayStatus.readOnly
                : EditAbsenceDayStatus.initial,
          ).copyWith(
            type: Absence.pure(day.type),
          ),
        ) {
    on<EditAbsenceDayStartEditing>(_onStartEditing);
    on<EditAbsenceDayCancelEditing>(_onCancelEditing);
    on<EditAbsenceDayTypeTimeChanged>(_onTypeChanged);
    on<EditAbsenceDaySubmitted>(_onSubmitted);
  }

  void _onStartEditing(
    EditAbsenceDayStartEditing event,
    Emitter<EditAbsenceDayState> emit,
  ) {
    final type = Absence.dirty(
      state.initialType,
    );
    emit(
      state.copyWith(
        status: EditAbsenceDayStatus.editing,
        type: type,
        isValid: Formz.validate([type]),
      ),
    );
  }

  void _onCancelEditing(
    EditAbsenceDayCancelEditing event,
    Emitter<EditAbsenceDayState> emit,
  ) {
    emit(
      state.copyWith(
        status: EditAbsenceDayStatus.initial,
        type: Absence.pure(
          state.initialType,
        ),
      ),
    );
  }

  void _onTypeChanged(
    EditAbsenceDayTypeTimeChanged event,
    Emitter<EditAbsenceDayState> emit,
  ) {
    final type = Absence.dirty(event.type);
    emit(
      state.copyWith(
        type: type,
        isValid: Formz.validate([type]),
      ),
    );
  }

  Future<void> _onSubmitted(
    EditAbsenceDaySubmitted event,
    Emitter<EditAbsenceDayState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: EditAbsenceDayStatus.done));
    }
  }
}
