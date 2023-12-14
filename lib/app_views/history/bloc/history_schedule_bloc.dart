import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:schedule_repository/schedule_repository.dart';

part 'history_schedule_event.dart';
part 'history_schedule_state.dart';

class HistoryScheduleBloc
    extends Bloc<HistoryScheduleEvent, HistoryScheduleState> {
  HistoryScheduleBloc({
    required ScheduleRepository scheduleRepository,
  })  : _scheduleRepository = scheduleRepository,
        super(
          HistoryScheduleState(focusedDay: DateTime.now()),
        ) {
    on<HistoryScheduleChangeFocusedDay>(
      _onFetchConfirmedMonth,
      transformer: restartable(),
    );
  }

  final ScheduleRepository _scheduleRepository;

  Future<void> _onFetchConfirmedMonth(
    HistoryScheduleChangeFocusedDay event,
    Emitter<HistoryScheduleState> emit,
  ) async {
    final newState = state.copyWith(
      status: HistoryScheduleStatus.loading,
      focusedDay: event.focusedDay,
    );
    emit(
      newState,
    );
    try {
      final map = await _scheduleRepository.getConfirmedMonthSchedule(
        userId: event.userId,
        month: event.focusedDay.month,
        year: event.focusedDay.year,
      );
      emit(
        newState.copyWith(
          status: HistoryScheduleStatus.success,
          monthSchedule: map,
        ),
      );
    } catch (e) {
      emit(
        newState.copyWith(
          status: HistoryScheduleStatus.success,
          monthSchedule: {},
        ),
      );
    }
  }
}
