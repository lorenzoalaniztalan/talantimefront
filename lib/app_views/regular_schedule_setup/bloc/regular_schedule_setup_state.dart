part of 'regular_schedule_setup_bloc.dart';

const initialTimeOfDay = TimeOfDay(hour: 0, minute: 0);

enum RegularScheduleSetupStatus {
  checking,
  checkingSuccess,
  checkingFailure,
  initial,
  editing,
  submitting,
  submittingSuccess,
  submittingFailure,
}

extension RegularScheduleStatusX on RegularScheduleSetupStatus {
  bool get canEdit => [
        RegularScheduleSetupStatus.editing,
        RegularScheduleSetupStatus.submittingFailure,
      ].contains(this);
  bool get isChecking => [
        RegularScheduleSetupStatus.checking,
      ].contains(this);
}

final class RegularScheduleSetupState extends Equatable {
  const RegularScheduleSetupState({
    this.status = RegularScheduleSetupStatus.initial,
    this.checkinTime = const CheckinTime.pure(),
    this.breakTime = const BreakTime.pure(),
    this.returnTime = const ReturnTime.pure(),
    this.checkoutTime = const CheckoutTime.pure(),
    this.fulltimeChecker = const Fulltime.pure(),
    this.oneHourBreakChecker = const OneHourBreak.pure(),
    this.initialCheckinTime = initialTimeOfDay,
    this.initialBreakTime = initialTimeOfDay,
    this.initialReturnTime = initialTimeOfDay,
    this.initialCheckoutTime = initialTimeOfDay,
    this.isValid = false,
  });

  final RegularScheduleSetupStatus status;
  final CheckinTime checkinTime;
  final BreakTime breakTime;
  final ReturnTime returnTime;
  final CheckoutTime checkoutTime;
  final TimeOfDay initialCheckinTime;
  final TimeOfDay initialBreakTime;
  final TimeOfDay initialReturnTime;
  final TimeOfDay initialCheckoutTime;
  final Fulltime fulltimeChecker;
  final OneHourBreak oneHourBreakChecker;
  final bool isValid;

  RegularScheduleSetupState copyWith({
    RegularScheduleSetupStatus? status,
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
    return RegularScheduleSetupState(
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
      oneHourBreakChecker: OneHourBreak.dirty(
        Duration(minutes: hoursDifference(xreturnTime.value, xbreakTime.value)),
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
        fulltimeChecker,
        oneHourBreakChecker,
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
      ),
      OneHourBreak.dirty(
        Duration(minutes: hoursDifference(xreturnTime.value, xbreakTime.value)),
      ),
    ];
    return values;
  }
}
