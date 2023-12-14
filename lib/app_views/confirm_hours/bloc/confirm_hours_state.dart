part of 'confirm_hours_bloc.dart';

enum ConfirmHoursStatus { initial, checking, checked, saving, success, failure }

enum MonthScheduleStatus { initial, checking, draft, confirmed }

enum MonthScheduleDataStatus { initial, editing }

extension ConfirmHoursStatusX on ConfirmHoursStatus {
  bool get isLoading => [
        ConfirmHoursStatus.checking,
        ConfirmHoursStatus.saving,
      ].contains(this);
}

extension MonthScheduleStatusX on MonthScheduleStatus {
  bool get isLoading => [
        MonthScheduleStatus.checking,
      ].contains(this);

  bool get isConfirmed => this == MonthScheduleStatus.confirmed;

  bool get isDraft => this == MonthScheduleStatus.draft;
}

extension MonthScheduleDataStatusX on MonthScheduleDataStatus {
  bool get isEditing => this == MonthScheduleDataStatus.editing;
}

final class ConfirmHoursState extends Equatable {
  const ConfirmHoursState({
    required this.currentDate,
    required this.firstAvailableDate,
    this.status = ConfirmHoursStatus.initial,
    this.monthScheduleStatus = MonthScheduleStatus.initial,
    this.unconfirmedMonths = const [],
    this.dataStatus = MonthScheduleDataStatus.initial,
    this.monthSchedule,
    this.updater = 0,
  });

  final ConfirmHoursStatus status;
  final MonthScheduleStatus monthScheduleStatus;
  final List<MonthTimeSerializable> unconfirmedMonths;
  final MonthScheduleDataStatus dataStatus;
  final DateTime currentDate;
  final DateTime firstAvailableDate;
  final MonthScheduleMap? monthSchedule;
  final int updater;

  ConfirmHoursState copyWith({
    DateTime? currentDate,
    DateTime? firstAvailableDate,
    ConfirmHoursStatus? status,
    MonthScheduleStatus? monthScheduleStatus,
    List<MonthTimeSerializable>? unconfirmedMonths,
    MonthScheduleDataStatus? dataStatus,
    MonthScheduleMap? monthSchedule,
    int? updater,
  }) {
    return ConfirmHoursState(
      currentDate: currentDate ?? this.currentDate,
      firstAvailableDate: firstAvailableDate ?? this.firstAvailableDate,
      status: status ?? this.status,
      monthScheduleStatus: monthScheduleStatus ?? this.monthScheduleStatus,
      unconfirmedMonths: unconfirmedMonths ?? this.unconfirmedMonths,
      monthSchedule: monthSchedule ?? this.monthSchedule,
      updater: updater ?? this.updater,
      dataStatus: dataStatus ?? this.dataStatus,
    );
  }

  @override
  List<Object?> get props => [
        currentDate,
        firstAvailableDate,
        status,
        monthScheduleStatus,
        unconfirmedMonths,
        dataStatus,
        monthSchedule,
        updater,
      ];
}
