part of 'schedule_report_bloc.dart';

final class ScheduleReportState extends Equatable {
  const ScheduleReportState({
    required this.startDate,
    required this.endDate,
    this.status = FormzSubmissionStatus.initial,
    this.userlist = const Userlist.pure(),
    this.officelist = const Officelist.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Userlist userlist;
  final Officelist officelist;
  final StartDate startDate;
  final EndDate endDate;
  final bool isValid;

  ScheduleReportState copyWith({
    FormzSubmissionStatus? status,
    Userlist? userlist,
    Officelist? officelist,
    bool? allUsers,
    StartDate? startDate,
    EndDate? endDate,
    bool? isValid,
  }) {
    return ScheduleReportState(
      status: status ?? this.status,
      userlist: userlist ?? this.userlist,
      officelist: officelist ?? this.officelist,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        userlist,
        officelist,
        startDate,
        endDate,
        isValid,
      ];
}
