part of 'schedule_report_bloc.dart';

sealed class ScheduleReportEvent extends Equatable {
  const ScheduleReportEvent();

  @override
  List<Object?> get props => [];
}

class RangeDateChanged extends ScheduleReportEvent {
  const RangeDateChanged({required this.rangeDate});

  final DateTimeRange rangeDate;

  @override
  List<Object?> get props => [rangeDate];
}

class UserlistChanged extends ScheduleReportEvent {
  const UserlistChanged(this.userlist);

  final List<int> userlist;

  @override
  List<Object?> get props => [userlist];
}

class OfficelistChanged extends ScheduleReportEvent {
  const OfficelistChanged(this.officelist);

  final List<String> officelist;

  @override
  List<Object?> get props => [officelist];
}

class AllUsersChanged extends ScheduleReportEvent {
  const AllUsersChanged({required this.allUsers});

  final bool allUsers;

  @override
  List<Object?> get props => [allUsers];
}

final class ScheduleReportSubmitted extends ScheduleReportEvent {
  const ScheduleReportSubmitted();
}
