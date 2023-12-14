part of 'edit_absence_day_bloc.dart';

sealed class EditAbsenceDayEvent extends Equatable {
  const EditAbsenceDayEvent();

  @override
  List<Object> get props => [];
}

final class EditAbsenceDayStartEditing extends EditAbsenceDayEvent {
  const EditAbsenceDayStartEditing();
}

final class EditAbsenceDayCancelEditing extends EditAbsenceDayEvent {
  const EditAbsenceDayCancelEditing();
}

final class EditAbsenceDaySubmitted extends EditAbsenceDayEvent {
  const EditAbsenceDaySubmitted();
}

final class EditAbsenceDayTypeTimeChanged extends EditAbsenceDayEvent {
  const EditAbsenceDayTypeTimeChanged(this.type);

  final AbsenceType type;

  @override
  List<Object> get props => [type];
}
