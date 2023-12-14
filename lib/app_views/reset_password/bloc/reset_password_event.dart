part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

final class ResetPasswordPasswordChanged extends ResetPasswordEvent {
  const ResetPasswordPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class ResetPasswordRepeatedPasswordChanged extends ResetPasswordEvent {
  const ResetPasswordRepeatedPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class ResetPasswordSubmitted extends ResetPasswordEvent {
  const ResetPasswordSubmitted();
}
