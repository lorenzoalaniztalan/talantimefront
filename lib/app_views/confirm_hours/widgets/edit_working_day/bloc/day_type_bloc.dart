import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'day_type_event.dart';
part 'day_type_state.dart';

class DayTypeBloc extends Bloc<DayTypeEvent, DayTypeState> {
  DayTypeBloc({
    required DateTime startDate,
    required DateTime endDate,
    required bool isWorkingDay,
    required bool isReadOnly,
  }) : super(
          DayTypeState(
            startDate: startDate,
            endDate: endDate,
            status: isReadOnly ? DayTypeStatus.readonly : DayTypeStatus.initial,
            dayType: isWorkingDay ? DayType.workingDay : DayType.absenceDay,
          ),
        ) {
    on<DayTypeStartEditing>(_onStartEditing);
    on<DayTypeCancelEditing>(_onCancelEditing);
    on<DayTypeSetEndDate>(_onSetEndDay);
    on<DayTypeSetWorking>(_onSetWorkingDay);
    on<DayTypeSetAbsence>(_onSetAbsenceDay);
  }

  void _onStartEditing(
    DayTypeStartEditing event,
    Emitter<DayTypeState> emit,
  ) {
    emit(
      state.copyWith(
        status: DayTypeStatus.editing,
      ),
    );
  }

  void _onCancelEditing(
    DayTypeCancelEditing event,
    Emitter<DayTypeState> emit,
  ) {
    emit(
      state.copyWith(
        status: DayTypeStatus.initial,
        endDate: state.startDate,
      ),
    );
  }

  void _onSetEndDay(
    DayTypeSetEndDate event,
    Emitter<DayTypeState> emit,
  ) {
    emit(
      state.copyWith(
        endDate: event.date,
      ),
    );
  }

  void _onSetWorkingDay(
    DayTypeSetWorking event,
    Emitter<DayTypeState> emit,
  ) {
    emit(
      state.copyWith(
        dayType: DayType.workingDay,
        status: DayTypeStatus.initial,
        endDate: state.startDate,
      ),
    );
  }

  void _onSetAbsenceDay(
    DayTypeSetAbsence event,
    Emitter<DayTypeState> emit,
  ) {
    emit(
      state.copyWith(
        dayType: DayType.absenceDay,
        status: DayTypeStatus.initial,
        endDate: state.startDate,
      ),
    );
  }
}
