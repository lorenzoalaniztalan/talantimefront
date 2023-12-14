part of 'confirm_hours_bloc.dart';

sealed class ConfirmHoursEvent extends Equatable {
  const ConfirmHoursEvent();

  @override
  List<Object> get props => [];
}

final class ConfirmHoursFirstRefresh extends ConfirmHoursEvent {
  const ConfirmHoursFirstRefresh();
}

final class ConfirmHoursRefresh extends ConfirmHoursEvent {
  const ConfirmHoursRefresh({
    required this.date,
  });
  final DateTime date;

  @override
  List<Object> get props => [date];
}

final class ConfirmHoursCancelNavigation extends ConfirmHoursEvent {
  const ConfirmHoursCancelNavigation();

  @override
  List<Object> get props => [];
}

final class ConfirmHoursEditedDay extends ConfirmHoursEvent {
  const ConfirmHoursEditedDay({
    required this.days,
  });
  final List<ScheduleDay> days;

  @override
  List<Object> get props => [days];
}

final class ConfirmHoursSubmitted extends ConfirmHoursEvent {
  const ConfirmHoursSubmitted({
    required this.userId,
  });
  final int userId;

  @override
  List<Object> get props => [userId];
}

final class ConfirmHoursDeleteRequestSubmitted extends ConfirmHoursEvent {
  const ConfirmHoursDeleteRequestSubmitted({
    required this.userId,
  });
  final int userId;

  @override
  List<Object> get props => [userId];
}
