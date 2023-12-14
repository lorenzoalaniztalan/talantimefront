part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class RegisterFirstnameChanged extends RegisterEvent {
  const RegisterFirstnameChanged(this.firstname);

  final String firstname;

  @override
  List<Object> get props => [firstname];
}

final class RegisterLastnameChanged extends RegisterEvent {
  const RegisterLastnameChanged(this.lastname);

  final String lastname;

  @override
  List<Object> get props => [lastname];
}

final class RegisterEmployeeIdChanged extends RegisterEvent {
  const RegisterEmployeeIdChanged(this.employeeId);

  final String employeeId;

  @override
  List<Object> get props => [employeeId];
}

final class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class RegisterOfficeChanged extends RegisterEvent {
  const RegisterOfficeChanged(this.office);

  final String office;

  @override
  List<Object> get props => [office];
}

final class RegisterRegistrationDateChanged extends RegisterEvent {
  const RegisterRegistrationDateChanged(this.registrationDate);

  final DateTime registrationDate;

  @override
  List<Object> get props => [registrationDate];
}

final class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}

final class RegisterResetForm extends RegisterEvent {
  const RegisterResetForm();
}
