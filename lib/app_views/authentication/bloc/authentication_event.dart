part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class _AuthenticationStatusChanged extends AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

final class AuthenticationEmailVerified extends AuthenticationEvent {}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}

final class AuthenticationUserAvatarRequested extends AuthenticationEvent {}
