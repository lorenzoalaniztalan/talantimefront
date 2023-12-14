import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:turnotron/app_views/register/models/models.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc(
    AuthenticationRepository authenticationRepository,
    String email,
    String token,
  )   : _authenticationRepository = authenticationRepository,
        super(ResetPasswordState(email: email, token: token)) {
    on<ResetPasswordPasswordChanged>(_onPasswordChanged);
    on<ResetPasswordRepeatedPasswordChanged>(_onRepeatedPasswordChanged);
    on<ResetPasswordSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onPasswordChanged(
    ResetPasswordPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    final password = Password.dirty(event.password);
    final repeatedPassword =
        RepeatedPassword.dirty(password.value, state.repeatedPassword.value);
    emit(
      state.copyWith(
        password: password,
        repeatedPassword: repeatedPassword,
        isValid: Formz.validate([
          password,
          repeatedPassword,
        ]),
      ),
    );
  }

  void _onRepeatedPasswordChanged(
    ResetPasswordRepeatedPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    final repeatedPassword =
        RepeatedPassword.dirty(state.password.value, event.password);
    emit(
      state.copyWith(
        repeatedPassword: repeatedPassword,
        isValid: Formz.validate([
          state.password,
          repeatedPassword,
        ]),
      ),
    );
  }

  Future<void> _onSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.resetPassword(
          email: state.email,
          password: state.password.value,
          token: state.token,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
