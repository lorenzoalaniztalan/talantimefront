part of 'history_schedule_bloc.dart';

sealed class HistoryScheduleEvent extends Equatable {
  const HistoryScheduleEvent();

  @override
  List<Object> get props => [];
}

final class HistoryScheduleChangeFocusedDay extends HistoryScheduleEvent {
  const HistoryScheduleChangeFocusedDay({
    required this.focusedDay,
    required this.userId,
  });
  final int userId;

  final DateTime focusedDay;

  @override
  List<Object> get props => [focusedDay];
}
