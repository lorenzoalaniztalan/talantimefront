part of 'edit_absence_day_bloc.dart';

enum EditAbsenceDayStatus {
  readOnly,
  initial,
  editing,
  done,
}

extension EditAbsenceDayStatusX on EditAbsenceDayStatus {
  bool get canEdit => [
        EditAbsenceDayStatus.editing,
      ].contains(this);
  bool get finishedEditing => this == EditAbsenceDayStatus.done;
  bool get isReadOnly => this == EditAbsenceDayStatus.readOnly;
}

final class EditAbsenceDayState extends Equatable {
  const EditAbsenceDayState({
    this.status = EditAbsenceDayStatus.initial,
    this.type = const Absence.pure(),
    this.initialType = const AbsenceType(id: -1, name: '', code: ''),
    this.isValid = false,
  });

  final EditAbsenceDayStatus status;
  final Absence type;
  final AbsenceType initialType;
  final bool isValid;

  EditAbsenceDayState copyWith({
    EditAbsenceDayStatus? status,
    Absence? type,
    AbsenceType? initialType,
    bool? isValid,
  }) {
    return EditAbsenceDayState(
      status: status ?? this.status,
      initialType: initialType ?? this.initialType,
      type: type ?? this.type,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        type,
        initialType,
        isValid,
      ];
}
