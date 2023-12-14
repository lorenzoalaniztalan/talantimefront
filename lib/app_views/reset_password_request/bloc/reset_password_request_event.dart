part of 'reset_password_request_bloc.dart';

sealed class ResetPasswordRequestEvent extends Equatable {
  const ResetPasswordRequestEvent();

  @override
  List<Object> get props => [];
}

final class ResetPasswordRequestEmailChanged extends ResetPasswordRequestEvent {
  const ResetPasswordRequestEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class ResetPasswordRequestSubmitted extends ResetPasswordRequestEvent {
  const ResetPasswordRequestSubmitted();
}
