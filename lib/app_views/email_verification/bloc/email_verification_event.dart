part of 'email_verification_bloc.dart';

sealed class EmailVerificationEvent extends Equatable {
  const EmailVerificationEvent();

  @override
  List<Object> get props => [];
}

final class EmailVerificationSubmitted extends EmailVerificationEvent {
  const EmailVerificationSubmitted({
    required this.email,
    required this.code,
  });
  final String email;
  final String code;

  @override
  List<Object> get props => [];
}
