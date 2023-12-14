part of 'edit_working_day_bloc.dart';

sealed class EditWorkingDayEvent extends Equatable {
  const EditWorkingDayEvent();

  @override
  List<Object> get props => [];
}

final class EditWorkingDayStartEditing extends EditWorkingDayEvent {
  const EditWorkingDayStartEditing();
}

final class EditWorkingDayCancelEditing extends EditWorkingDayEvent {
  const EditWorkingDayCancelEditing();
}

final class EditWorkingDaySubmitted extends EditWorkingDayEvent {
  const EditWorkingDaySubmitted();
}

final class EditWorkingDayCheckinTimeChanged extends EditWorkingDayEvent {
  const EditWorkingDayCheckinTimeChanged(this.checkinTime);

  final TimeOfDay checkinTime;

  @override
  List<Object> get props => [checkinTime];
}

final class EditWorkingDayBreakTimeChanged extends EditWorkingDayEvent {
  const EditWorkingDayBreakTimeChanged(this.breakTime);

  final TimeOfDay breakTime;

  @override
  List<Object> get props => [breakTime];
}

final class EditWorkingDayReturnTimeChanged extends EditWorkingDayEvent {
  const EditWorkingDayReturnTimeChanged(this.returnTime);

  final TimeOfDay returnTime;

  @override
  List<Object> get props => [returnTime];
}

final class EditWorkingDayCheckoutTimeChanged extends EditWorkingDayEvent {
  const EditWorkingDayCheckoutTimeChanged(this.checkoutTime);

  final TimeOfDay checkoutTime;

  @override
  List<Object> get props => [checkoutTime];
}
