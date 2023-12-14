part of 'email_verification_bloc.dart';

final class EmailVerificationState extends Equatable {
  const EmailVerificationState({
    this.status = FormzSubmissionStatus.initial,
    this.email = '',
    this.code = '',
  });

  final FormzSubmissionStatus status;
  final String email;
  final String code;

  EmailVerificationState copyWith({
    FormzSubmissionStatus? status,
    String? email,
    String? code,
  }) {
    return EmailVerificationState(
      status: status ?? this.status,
      email: email ?? this.email,
      code: code ?? this.code,
    );
  }

  @override
  List<Object> get props => [status, email, code];
}
