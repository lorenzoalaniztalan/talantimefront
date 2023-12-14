part of 'register_bloc.dart';

final class RegisterState extends Equatable {
  RegisterState({
    this.status = FormzSubmissionStatus.initial,
    this.firstname = const Firstname.pure(),
    this.lastname = const Lastname.pure(),
    this.employeeId = const EmployeeId.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.officeCode = const OfficeCode.pure(),
    RegistrationDate? creationDate,
    this.responseCode = 0,
    this.isValid = false,
  }) {
    registrationDate = creationDate ?? RegistrationDate.pure(DateTime.now());
  }

  final FormzSubmissionStatus status;
  final Firstname firstname;
  final Lastname lastname;
  final EmployeeId employeeId;
  final Email email;
  final Password password;
  final OfficeCode officeCode;
  late final RegistrationDate registrationDate;
  final int responseCode;
  final bool isValid;

  RegisterState copyWith({
    FormzSubmissionStatus? status,
    Firstname? firstname,
    Lastname? lastname,
    EmployeeId? employeeId,
    Email? email,
    Password? password,
    OfficeCode? officeCode,
    RegistrationDate? registrationDate,
    int? responseCode,
    bool? isValid,
  }) {
    return RegisterState(
      status: status ?? this.status,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      employeeId: employeeId ?? this.employeeId,
      email: email ?? this.email,
      password: password ?? this.password,
      officeCode: officeCode ?? this.officeCode,
      creationDate: registrationDate ?? this.registrationDate,
      responseCode: responseCode ?? this.responseCode,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        firstname,
        lastname,
        employeeId,
        email,
        password,
        officeCode,
        registrationDate,
        responseCode,
        isValid,
      ];
}
