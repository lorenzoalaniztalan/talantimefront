part of 'regular_schedule_setup_bloc.dart';

sealed class RegularScheduleSetupEvent extends Equatable {
  const RegularScheduleSetupEvent();

  @override
  List<Object> get props => [];
}

final class RegularScheduleSetupChecking extends RegularScheduleSetupEvent {
  const RegularScheduleSetupChecking();
}

final class RegularScheduleSetupCheckingSuccess
    extends RegularScheduleSetupEvent {
  const RegularScheduleSetupCheckingSuccess();
}

final class RegularScheduleSetupStartEditing extends RegularScheduleSetupEvent {
  const RegularScheduleSetupStartEditing();
}

final class RegularScheduleSetupCancelEditing
    extends RegularScheduleSetupEvent {
  const RegularScheduleSetupCancelEditing();
}

final class RegularScheduleSetupSubmitted extends RegularScheduleSetupEvent {
  const RegularScheduleSetupSubmitted();
}

final class RegularScheduleSetupCheckinTimeChanged
    extends RegularScheduleSetupEvent {
  const RegularScheduleSetupCheckinTimeChanged(this.checkinTime);

  final TimeOfDay checkinTime;

  @override
  List<Object> get props => [checkinTime];
}

final class RegularScheduleSetupBreakTimeChanged
    extends RegularScheduleSetupEvent {
  const RegularScheduleSetupBreakTimeChanged(this.breakTime);

  final TimeOfDay breakTime;

  @override
  List<Object> get props => [breakTime];
}

final class RegularScheduleSetupReturnTimeChanged
    extends RegularScheduleSetupEvent {
  const RegularScheduleSetupReturnTimeChanged(this.returnTime);

  final TimeOfDay returnTime;

  @override
  List<Object> get props => [returnTime];
}

final class RegularScheduleSetupCheckoutTimeChanged
    extends RegularScheduleSetupEvent {
  const RegularScheduleSetupCheckoutTimeChanged(this.checkoutTime);

  final TimeOfDay checkoutTime;

  @override
  List<Object> get props => [checkoutTime];
}
