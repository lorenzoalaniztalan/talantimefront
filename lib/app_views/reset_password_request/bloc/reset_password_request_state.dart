part of 'reset_password_request_bloc.dart';

final class ResetPasswordRequestState extends Equatable {
  const ResetPasswordRequestState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final bool isValid;

  ResetPasswordRequestState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    bool? isValid,
  }) {
    return ResetPasswordRequestState(
      status: status ?? this.status,
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        email,
        isValid,
      ];
}
