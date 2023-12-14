part of 'edit_working_day_bloc.dart';

const initialTimeOfDay = TimeOfDay(hour: 0, minute: 0);

enum EditWorkingDayStatus {
  readOnly,
  initial,
  editing,
  done,
}

extension EditWorkingDayStatusX on EditWorkingDayStatus {
  bool get canEdit => [
        EditWorkingDayStatus.editing,
      ].contains(this);
  bool get finishedEditing => this == EditWorkingDayStatus.done;
  bool get isReadOnly => this == EditWorkingDayStatus.readOnly;
}

final class EditWorkingDayState extends Equatable {
  const EditWorkingDayState({
    this.status = EditWorkingDayStatus.initial,
    this.checkinTime = const CheckinTime.pure(),
    this.breakTime = const BreakTime.pure(),
    this.returnTime = const ReturnTime.pure(),
    this.checkoutTime = const CheckoutTime.pure(),
    this.fulltimeChecker = const Fulltime.pure(),
    this.initialCheckinTime = initialTimeOfDay,
    this.initialBreakTime = initialTimeOfDay,
    this.initialReturnTime = initialTimeOfDay,
    this.initialCheckoutTime = initialTimeOfDay,
    this.isValid = false,
  });

  final EditWorkingDayStatus status;
  final CheckinTime checkinTime;
  final BreakTime breakTime;
  final ReturnTime returnTime;
  final CheckoutTime checkoutTime;
  final TimeOfDay initialCheckinTime;
  final TimeOfDay initialBreakTime;
  final TimeOfDay initialReturnTime;
  final TimeOfDay initialCheckoutTime;
  final Fulltime fulltimeChecker;
  final bool isValid;

  EditWorkingDayState copyWith({
    EditWorkingDayStatus? status,
    CheckinTime? checkinTime,
    BreakTime? breakTime,
    ReturnTime? returnTime,
    CheckoutTime? checkoutTime,
    TimeOfDay? initialCheckinTime,
    TimeOfDay? initialBreakTime,
    TimeOfDay? initialReturnTime,
    TimeOfDay? initialCheckoutTime,
    bool? isValid,
  }) {
    final xstatus = status ?? this.status;
    final xcheckinTime = checkinTime ?? this.checkinTime;
    final xbreakTime = breakTime ?? this.breakTime;
    final xreturnTime = returnTime ?? this.returnTime;
    final xcheckoutTime = checkoutTime ?? this.checkoutTime;
    final xisValid = isValid ?? this.isValid;
    return EditWorkingDayState(
      status: xstatus,
      initialCheckinTime: initialCheckinTime ?? this.initialCheckinTime,
      initialBreakTime: initialBreakTime ?? this.initialBreakTime,
      initialReturnTime: initialReturnTime ?? this.initialReturnTime,
      initialCheckoutTime: initialCheckoutTime ?? this.initialCheckoutTime,
      checkinTime: xcheckinTime,
      breakTime: xbreakTime,
      returnTime: xreturnTime,
      checkoutTime: xcheckoutTime,
      isValid: xisValid,
      fulltimeChecker: Fulltime.dirty(
        totalSumOfHours(
          checkinTime: xcheckinTime.value,
          breakTime: xbreakTime.value,
          returnTime: xreturnTime.value,
          checkoutTime: xcheckoutTime.value,
        ),
      ),
    );
  }

  @override
  List<Object> get props => [
        status,
        checkinTime,
        breakTime,
        returnTime,
        checkoutTime,
        isValid,
      ];

  List<FormzInput<dynamic, dynamic>> getAndReplaceFormValues({
    CheckinTime? checkinTime,
    BreakTime? breakTime,
    ReturnTime? returnTime,
    CheckoutTime? checkoutTime,
  }) {
    final xcheckinTime = checkinTime ?? this.checkinTime;
    final xbreakTime = breakTime ?? this.breakTime;
    final xreturnTime = returnTime ?? this.returnTime;
    final xcheckoutTime = checkoutTime ?? this.checkoutTime;
    final values = <FormzInput<dynamic, dynamic>>[
      xcheckinTime,
      xbreakTime,
      xreturnTime,
      xcheckoutTime,
      Fulltime.dirty(
        totalSumOfHours(
          checkinTime: xcheckinTime.value,
          breakTime: xbreakTime.value,
          returnTime: xreturnTime.value,
          checkoutTime: xcheckoutTime.value,
        ),
      )
    ];
    return values;
  }
}
