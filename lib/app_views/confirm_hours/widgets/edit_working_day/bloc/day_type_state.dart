part of 'day_type_bloc.dart';

enum DayTypeStatus { readonly, initial, editing }

extension DayTypeStatusX on DayTypeStatus {
  bool get canEdit => [
        DayTypeStatus.editing,
      ].contains(this);

  bool get isReadOnly => this == DayTypeStatus.readonly;
}

enum DayType { workingDay, absenceDay }

extension DayTypeX on DayType {
  bool get isWorkingDay => this == DayType.workingDay;
}

final class DayTypeState extends Equatable {
  const DayTypeState({
    required this.startDate,
    required this.endDate,
    this.status = DayTypeStatus.initial,
    this.dayType = DayType.workingDay,
  });

  final DayTypeStatus status;
  final DayType dayType;
  final DateTime startDate;
  final DateTime endDate;

  DayTypeState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    DayTypeStatus? status,
    DayType? dayType,
  }) {
    return DayTypeState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      dayType: dayType ?? this.dayType,
    );
  }

  @override
  List<Object> get props => [
        startDate,
        endDate,
        status,
        dayType,
      ];
}
