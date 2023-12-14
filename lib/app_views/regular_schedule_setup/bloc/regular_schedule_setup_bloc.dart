import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:http_schedule_api/http_schedule_api.dart';
import 'package:schedule_repository/schedule_repository.dart';
import 'package:turnotron/app_views/regular_schedule_setup/model/break_time.dart';
import 'package:turnotron/app_views/regular_schedule_setup/model/checkin_time.dart';
import 'package:turnotron/app_views/regular_schedule_setup/model/checkout_time.dart';
import 'package:turnotron/app_views/regular_schedule_setup/model/fulltime.dart';
import 'package:turnotron/app_views/regular_schedule_setup/model/one_hour_break.dart';
import 'package:turnotron/app_views/regular_schedule_setup/model/return_time.dart';
import 'package:turnotron/utils/time_utils.dart';

part 'regular_schedule_setup_event.dart';
part 'regular_schedule_setup_state.dart';

class RegularScheduleSetupBloc
    extends Bloc<RegularScheduleSetupEvent, RegularScheduleSetupState> {
  RegularScheduleSetupBloc(
    ScheduleRepository scheduleRepository,
  )   : _scheduleRepository = scheduleRepository,
        super(
          const RegularScheduleSetupState(
            status: RegularScheduleSetupStatus.checking,
          ),
        ) {
    on<RegularScheduleSetupChecking>(_onCheckingFavoriteSchedule);
    on<RegularScheduleSetupCheckingSuccess>(_onCheckingFavoriteScheduleSuccess);
    on<RegularScheduleSetupStartEditing>(_onStartEditing);
    on<RegularScheduleSetupCancelEditing>(_onCancelEditing);
    on<RegularScheduleSetupCheckinTimeChanged>(_onCheckinTimeChanged);
    on<RegularScheduleSetupBreakTimeChanged>(_onBreakTimeChanged);
    on<RegularScheduleSetupReturnTimeChanged>(_onReturnTimeChanged);
    on<RegularScheduleSetupCheckoutTimeChanged>(_onCheckoutTimeChanged);
    on<RegularScheduleSetupSubmitted>(_onSubmitted);
  }

  final ScheduleRepository _scheduleRepository;

  Future<void> _onCheckingFavoriteSchedule(
    RegularScheduleSetupChecking event,
    Emitter<RegularScheduleSetupState> emit,
  ) async {
    emit(state.copyWith(status: RegularScheduleSetupStatus.checking));
    try {
      final res = await _scheduleRepository.getUsualSchedule();
      final checkinTime = CheckinTime.pure(res.startTime);
      final breakTime = BreakTime.pure(res.breakTime);
      final returnTime = ReturnTime.pure(res.returnTime);
      final checkoutTime = CheckoutTime.pure(res.finishTime);
      emit(
        state.copyWith(
          status: RegularScheduleSetupStatus.checkingSuccess,
          initialCheckinTime: res.startTime,
          initialBreakTime: res.breakTime,
          initialReturnTime: res.returnTime,
          initialCheckoutTime: res.finishTime,
          checkinTime: checkinTime,
          breakTime: breakTime,
          returnTime: returnTime,
          checkoutTime: checkoutTime,
          isValid: Formz.validate(
            state.getAndReplaceFormValues(
              checkinTime: checkinTime,
              breakTime: breakTime,
              returnTime: returnTime,
              checkoutTime: checkoutTime,
            ),
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RegularScheduleSetupStatus.checkingFailure));
    }
  }

  void _onCheckingFavoriteScheduleSuccess(
    RegularScheduleSetupCheckingSuccess event,
    Emitter<RegularScheduleSetupState> emit,
  ) {
    emit(state.copyWith(status: RegularScheduleSetupStatus.initial));
  }

  void _onStartEditing(
    RegularScheduleSetupStartEditing event,
    Emitter<RegularScheduleSetupState> emit,
  ) {
    emit(
      state.copyWith(
        status: RegularScheduleSetupStatus.editing,
        checkinTime: CheckinTime.dirty(
          state.initialCheckinTime,
        ),
        breakTime: BreakTime.dirty(
          state.initialCheckinTime,
          state.initialBreakTime,
        ),
        returnTime: ReturnTime.dirty(
          state.initialBreakTime,
          state.initialReturnTime,
        ),
        checkoutTime: CheckoutTime.dirty(
          state.initialReturnTime,
          state.initialCheckoutTime,
        ),
      ),
    );
  }

  void _onCancelEditing(
    RegularScheduleSetupCancelEditing event,
    Emitter<RegularScheduleSetupState> emit,
  ) {
    emit(
      state.copyWith(
        status: RegularScheduleSetupStatus.initial,
        checkinTime: CheckinTime.pure(
          state.initialCheckinTime,
        ),
        breakTime: BreakTime.pure(
          state.initialBreakTime,
        ),
        returnTime: ReturnTime.pure(
          state.initialReturnTime,
        ),
        checkoutTime: CheckoutTime.pure(
          state.initialCheckoutTime,
        ),
      ),
    );
  }

  void _onCheckinTimeChanged(
    RegularScheduleSetupCheckinTimeChanged event,
    Emitter<RegularScheduleSetupState> emit,
  ) {
    final checkinTime = CheckinTime.dirty(event.checkinTime);
    final breakTime = BreakTime.dirty(checkinTime.value, state.breakTime.value);
    emit(
      state.copyWith(
        checkinTime: checkinTime,
        breakTime: breakTime,
        isValid: Formz.validate(
          state.getAndReplaceFormValues(
            checkinTime: checkinTime,
            breakTime: breakTime,
          ),
        ),
      ),
    );
  }

  void _onBreakTimeChanged(
    RegularScheduleSetupBreakTimeChanged event,
    Emitter<RegularScheduleSetupState> emit,
  ) {
    final breakTime = BreakTime.dirty(state.checkinTime.value, event.breakTime);
    final returnTime =
        ReturnTime.dirty(breakTime.value, state.returnTime.value);
    emit(
      state.copyWith(
        breakTime: breakTime,
        returnTime: returnTime,
        isValid: Formz.validate(
          state.getAndReplaceFormValues(
            breakTime: breakTime,
            returnTime: returnTime,
          ),
        ),
      ),
    );
  }

  void _onReturnTimeChanged(
    RegularScheduleSetupReturnTimeChanged event,
    Emitter<RegularScheduleSetupState> emit,
  ) {
    final returnTime =
        ReturnTime.dirty(state.breakTime.value, event.returnTime);
    final checkout =
        CheckoutTime.dirty(returnTime.value, state.checkoutTime.value);
    emit(
      state.copyWith(
        returnTime: returnTime,
        checkoutTime: checkout,
        isValid: Formz.validate(
          state.getAndReplaceFormValues(
            returnTime: returnTime,
            checkoutTime: checkout,
          ),
        ),
      ),
    );
  }

  void _onCheckoutTimeChanged(
    RegularScheduleSetupCheckoutTimeChanged event,
    Emitter<RegularScheduleSetupState> emit,
  ) {
    final checkoutTime =
        CheckoutTime.dirty(state.returnTime.value, event.checkoutTime);
    emit(
      state.copyWith(
        checkoutTime: checkoutTime,
        isValid: Formz.validate(
          state.getAndReplaceFormValues(checkoutTime: checkoutTime),
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    RegularScheduleSetupSubmitted event,
    Emitter<RegularScheduleSetupState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: RegularScheduleSetupStatus.submitting));
      try {
        await _scheduleRepository.setUsualSchedule(
          ScheduleHoursTime(
            startTime:
                TimeOfDaySerializable.fromTimeOfDay(state.checkinTime.value),
            breakTime:
                TimeOfDaySerializable.fromTimeOfDay(state.breakTime.value),
            returnTime:
                TimeOfDaySerializable.fromTimeOfDay(state.returnTime.value),
            finishTime:
                TimeOfDaySerializable.fromTimeOfDay(state.checkoutTime.value),
          ),
        );
        emit(
          state.copyWith(
            status: RegularScheduleSetupStatus.submittingSuccess,
            initialCheckinTime: state.checkinTime.value,
            initialBreakTime: state.breakTime.value,
            initialReturnTime: state.returnTime.value,
            initialCheckoutTime: state.checkoutTime.value,
          ),
        );
      } catch (_) {
        emit(
          state.copyWith(
            status: RegularScheduleSetupStatus.submittingFailure,
          ),
        );
      }
    }
  }
}
