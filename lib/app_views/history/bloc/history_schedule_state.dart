part of 'history_schedule_bloc.dart';

enum HistoryScheduleStatus { initial, loading, success, failure }

extension HistoryScheduleStatusX on HistoryScheduleStatus {
  bool get isLoading => [
        HistoryScheduleStatus.loading,
      ].contains(this);
}

final class HistoryScheduleState extends Equatable {
  const HistoryScheduleState({
    required this.focusedDay,
    this.status = HistoryScheduleStatus.initial,
    this.monthSchedule = const {},
  });

  final DateTime focusedDay;
  final HistoryScheduleStatus status;
  final MonthScheduleMap monthSchedule;

  HistoryScheduleState copyWith({
    DateTime? focusedDay,
    HistoryScheduleStatus? status,
    MonthScheduleMap? monthSchedule,
  }) {
    return HistoryScheduleState(
      focusedDay: focusedDay ?? this.focusedDay,
      status: status ?? this.status,
      monthSchedule: monthSchedule ?? this.monthSchedule,
    );
  }

  @override
  List<Object> get props => [status, monthSchedule];
}
