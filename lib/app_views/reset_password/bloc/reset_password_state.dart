part of 'reset_password_bloc.dart';

final class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    required this.email,
    required this.token,
    this.status = FormzSubmissionStatus.initial,
    this.password = const Password.pure(),
    this.repeatedPassword = const RepeatedPassword.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final String email;
  final String token;
  final Password password;
  final RepeatedPassword repeatedPassword;
  final bool isValid;

  ResetPasswordState copyWith({
    FormzSubmissionStatus? status,
    Password? password,
    RepeatedPassword? repeatedPassword,
    bool? isValid,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      password: password ?? this.password,
      repeatedPassword: repeatedPassword ?? this.repeatedPassword,
      isValid: isValid ?? this.isValid,
      email: email,
      token: token,
    );
  }

  @override
  List<Object> get props => [
        status,
        password,
        repeatedPassword,
        isValid,
        email,
        token,
      ];
}
