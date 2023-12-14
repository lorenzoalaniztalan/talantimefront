import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:http_schedule_api/http_schedule_api.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:turnotron/app_views/regular_schedule_setup/model/break_time.dart';
import 'package:turnotron/app_views/regular_schedule_setup/model/checkin_time.dart';
import 'package:turnotron/app_views/regular_schedule_setup/model/checkout_time.dart';
import 'package:turnotron/app_views/regular_schedule_setup/model/fulltime.dart';
import 'package:turnotron/app_views/regular_schedule_setup/model/return_time.dart';
import 'package:turnotron/utils/time_utils.dart';

part 'edit_working_day_event.dart';
part 'edit_working_day_state.dart';

class EditWorkingDayBloc
    extends Bloc<EditWorkingDayEvent, EditWorkingDayState> {
  EditWorkingDayBloc({
    required WorkingDay day,
    required bool isReadOnly,
  }) : super(
          EditWorkingDayState(
            status: isReadOnly
                ? EditWorkingDayStatus.readOnly
                : EditWorkingDayStatus.initial,
            initialCheckinTime:
                TimeOfDaySerializable.parse(day.startOne).replacing(),
            initialBreakTime:
                TimeOfDaySerializable.parse(day.finishOne).replacing(),
            initialReturnTime:
                TimeOfDaySerializable.parse(day.startTwo).replacing(),
            initialCheckoutTime:
                TimeOfDaySerializable.parse(day.finishTwo).replacing(),
          ).copyWith(
            checkinTime: CheckinTime.pure(
              TimeOfDaySerializable.parse(day.startOne).replacing(),
            ),
            breakTime: BreakTime.pure(
              TimeOfDaySerializable.parse(day.finishOne).replacing(),
            ),
            returnTime: ReturnTime.pure(
              TimeOfDaySerializable.parse(day.startTwo).replacing(),
            ),
            checkoutTime: CheckoutTime.pure(
              TimeOfDaySerializable.parse(day.finishTwo).replacing(),
            ),
          ),
        ) {
    on<EditWorkingDayStartEditing>(_onStartEditing);
    on<EditWorkingDayCancelEditing>(_onCancelEditing);
    on<EditWorkingDayCheckinTimeChanged>(_onCheckinTimeChanged);
    on<EditWorkingDayBreakTimeChanged>(_onBreakTimeChanged);
    on<EditWorkingDayReturnTimeChanged>(_onReturnTimeChanged);
    on<EditWorkingDayCheckoutTimeChanged>(_onCheckoutTimeChanged);
    on<EditWorkingDaySubmitted>(_onSubmitted);
  }

  void _onStartEditing(
    EditWorkingDayStartEditing event,
    Emitter<EditWorkingDayState> emit,
  ) {
    emit(
      state.copyWith(
        status: EditWorkingDayStatus.editing,
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
        isValid: Formz.validate(state.getAndReplaceFormValues()),
      ),
    );
  }

  void _onCancelEditing(
    EditWorkingDayCancelEditing event,
    Emitter<EditWorkingDayState> emit,
  ) {
    emit(
      state.copyWith(
        status: EditWorkingDayStatus.initial,
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
    EditWorkingDayCheckinTimeChanged event,
    Emitter<EditWorkingDayState> emit,
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
    EditWorkingDayBreakTimeChanged event,
    Emitter<EditWorkingDayState> emit,
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
    EditWorkingDayReturnTimeChanged event,
    Emitter<EditWorkingDayState> emit,
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
    EditWorkingDayCheckoutTimeChanged event,
    Emitter<EditWorkingDayState> emit,
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
    EditWorkingDaySubmitted event,
    Emitter<EditWorkingDayState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: EditWorkingDayStatus.done));
    }
  }
}
