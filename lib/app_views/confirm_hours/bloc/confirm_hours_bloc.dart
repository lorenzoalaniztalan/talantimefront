import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:schedule_repository/schedule_repository.dart';

part 'confirm_hours_event.dart';
part 'confirm_hours_state.dart';

class ConfirmHoursBloc extends Bloc<ConfirmHoursEvent, ConfirmHoursState> {
  ConfirmHoursBloc({
    required ScheduleRepository scheduleRepository,
    required int userId,
    required DateTime firstAvailableDate,
  })  : _scheduleRepository = scheduleRepository,
        _userId = userId,
        super(
          ConfirmHoursState(
            currentDate: DateTime.now(),
            status: ConfirmHoursStatus.checking,
            monthScheduleStatus: MonthScheduleStatus.checking,
            firstAvailableDate: firstAvailableDate,
          ),
        ) {
    on<ConfirmHoursFirstRefresh>(
      _onFirstRefresh,
      transformer: restartable(),
    );
    on<ConfirmHoursRefresh>(
      _onRefresh,
      transformer: restartable(),
    );
    on<ConfirmHoursEditedDay>(_onDayEdited);
    on<ConfirmHoursCancelNavigation>(_onCancelNavigation);
    on<ConfirmHoursSubmitted>(_onSubmitted);
    on<ConfirmHoursDeleteRequestSubmitted>(_onDeleteRequestSubmitted);
  }

  final ScheduleRepository _scheduleRepository;
  final int _userId;

  Future<void> _onFirstRefresh(
    ConfirmHoursFirstRefresh event,
    Emitter<ConfirmHoursState> emit,
  ) async {
    final now = DateTime.now();
    emit(
      state.copyWith(
        status: ConfirmHoursStatus.checking,
        monthScheduleStatus: MonthScheduleStatus.checking,
        currentDate: now,
        dataStatus: MonthScheduleDataStatus.initial,
      ),
    );
    try {
      final res = await Future.wait([
        _scheduleRepository.getUnconfirmedMonths(_userId),
        _scheduleRepository.getMonthSchedule(
          userId: _userId,
          month: now.month,
          year: now.year,
        ),
      ]);
      final unconfirmedMonths = res[0] as List<MonthTimeSerializable>;
      final monthData = res[1] as MonthScheduleData;
      emit(
        state.copyWith(
          status: ConfirmHoursStatus.checked,
          dataStatus: MonthScheduleDataStatus.initial,
          monthScheduleStatus: monthData.draft
              ? MonthScheduleStatus.draft
              : MonthScheduleStatus.confirmed,
          monthSchedule: monthData.data,
          currentDate: now,
          unconfirmedMonths: unconfirmedMonths,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ConfirmHoursStatus.failure,
          monthScheduleStatus: MonthScheduleStatus.initial,
          currentDate: now,
        ),
      );
    }
  }

  Future<void> _onRefresh(
    ConfirmHoursRefresh event,
    Emitter<ConfirmHoursState> emit,
  ) async {
    final date = event.date.isAfter(state.firstAvailableDate)
        ? event.date
        : state.firstAvailableDate;
    emit(
      state.copyWith(
        status: ConfirmHoursStatus.checking,
        monthScheduleStatus: MonthScheduleStatus.checking,
        currentDate: date,
        dataStatus: MonthScheduleDataStatus.initial,
      ),
    );
    try {
      final monthData = await _scheduleRepository.getMonthSchedule(
        userId: _userId,
        month: date.month,
        year: date.year,
      );
      emit(
        state.copyWith(
          status: ConfirmHoursStatus.checked,
          dataStatus: MonthScheduleDataStatus.initial,
          monthScheduleStatus: monthData.draft
              ? MonthScheduleStatus.draft
              : MonthScheduleStatus.confirmed,
          monthSchedule: monthData.data,
          currentDate: date,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ConfirmHoursStatus.failure,
          monthScheduleStatus: MonthScheduleStatus.initial,
          currentDate: date,
        ),
      );
    }
  }

  void _onCancelNavigation(
    ConfirmHoursCancelNavigation event,
    Emitter<ConfirmHoursState> emit,
  ) {
    emit(
      state.copyWith(
        updater: state.updater + 1,
      ),
    );
  }

  Future<void> _onDayEdited(
    ConfirmHoursEditedDay event,
    Emitter<ConfirmHoursState> emit,
  ) async {
    final newDays = List<WorkingDay>.from(event.days);
    final newSchedule = {...state.monthSchedule!};
    for (final day in newDays) {
      if (shouldUpdateDay(day, state)) {
        final updatedDay = WorkingDay(
          day: day.day,
          month: day.month,
          year: day.year,
          startOne: day.startOne,
          finishOne: day.finishOne,
          startTwo: day.startTwo,
          finishTwo: day.finishTwo,
          confirmed: true,
        );
        newSchedule[day.day] = updatedDay;
      }
    }
    emit(
      state.copyWith(
        monthSchedule: newSchedule,
        dataStatus: MonthScheduleDataStatus.editing,
      ),
    );

    emit(state.copyWith(status: ConfirmHoursStatus.saving));
    try {
      await _scheduleRepository.sendDayConfirmation(
        userId: _userId,
        day: newDays[0], // We only send the selected day on this point
      );
      final unconfirmed =
          await _scheduleRepository.getUnconfirmedMonths(_userId);
      final monthData = await _scheduleRepository.getMonthSchedule(
        userId: _userId,
        month: newDays[0].month,
        year: newDays[0].year,
      );

      final hasUnconfirmed = monthData.data.values
          .where((day) => day.confirmed == false)
          .isNotEmpty;

      emit(
        state.copyWith(
          monthSchedule: monthData.data,
          status: ConfirmHoursStatus.success,
          monthScheduleStatus: hasUnconfirmed
              ? MonthScheduleStatus.draft
              : MonthScheduleStatus.confirmed,
          dataStatus: MonthScheduleDataStatus.initial,
          unconfirmedMonths: unconfirmed,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ConfirmHoursStatus.failure));
    }
  }

  Future<void> _onSubmitted(
    ConfirmHoursSubmitted event,
    Emitter<ConfirmHoursState> emit,
  ) async {
    emit(state.copyWith(status: ConfirmHoursStatus.saving));
    try {
      await _scheduleRepository.sendMonthScheduleConfirmation(
        userId: _userId,
        monthSchedule: state.monthSchedule!,
      );
      final unconfirmed =
          await _scheduleRepository.getUnconfirmedMonths(_userId);
      emit(
        state.copyWith(
          status: ConfirmHoursStatus.success,
          monthScheduleStatus: MonthScheduleStatus.confirmed,
          dataStatus: MonthScheduleDataStatus.initial,
          unconfirmedMonths: unconfirmed,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ConfirmHoursStatus.failure));
    }
  }

  FutureOr<void> _onDeleteRequestSubmitted(
      ConfirmHoursDeleteRequestSubmitted event,
      Emitter<ConfirmHoursState> emit) async {
    emit(state.copyWith(status: ConfirmHoursStatus.saving));
    try {
      await _scheduleRepository.deleteMonthScheduleConfirmation(
        userId: _userId,
        month: state.currentDate.month,
        year: state.currentDate.year,
      );
      final unconfirmed =
          await _scheduleRepository.getUnconfirmedMonths(_userId);
      emit(
        state.copyWith(
          status: ConfirmHoursStatus.success,
          monthScheduleStatus: MonthScheduleStatus.draft,
          dataStatus: MonthScheduleDataStatus.initial,
          unconfirmedMonths: unconfirmed,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ConfirmHoursStatus.failure));
    }
  }
}

bool shouldUpdateDay(
  ScheduleDay day,
  ConfirmHoursState state,
) {
  final date = day.toDateTime();
  return date.isAfter(state.firstAvailableDate) &&
      date.weekday < 6 &&
      state.monthSchedule?[day.day] is! NonWorkingDay;
}
