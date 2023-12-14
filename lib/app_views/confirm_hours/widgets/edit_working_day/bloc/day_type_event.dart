part of 'day_type_bloc.dart';

sealed class DayTypeEvent extends Equatable {
  const DayTypeEvent();

  @override
  List<Object> get props => [];
}

final class DayTypeStartEditing extends DayTypeEvent {
  const DayTypeStartEditing();
}

final class DayTypeCancelEditing extends DayTypeEvent {
  const DayTypeCancelEditing();
}

final class DayTypeSetWorking extends DayTypeEvent {
  const DayTypeSetWorking();
}

final class DayTypeSetEndDate extends DayTypeEvent {
  const DayTypeSetEndDate({
    required this.date,
  });
  final DateTime date;

  @override
  List<Object> get props => [date];
}

final class DayTypeSetAbsence extends DayTypeEvent {
  const DayTypeSetAbsence();
}
