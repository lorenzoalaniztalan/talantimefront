import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:turnotron/app_views/register/models/models.dart';

part 'reset_password_request_event.dart';
part 'reset_password_request_state.dart';

class ResetPasswordRequestBloc
    extends Bloc<ResetPasswordRequestEvent, ResetPasswordRequestState> {
  ResetPasswordRequestBloc(
    AuthenticationRepository authenticationRepository,
  )   : _authenticationRepository = authenticationRepository,
        super(const ResetPasswordRequestState()) {
    on<ResetPasswordRequestEmailChanged>(_onEmailChanged);
    on<ResetPasswordRequestSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(
    ResetPasswordRequestEmailChanged event,
    Emitter<ResetPasswordRequestState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
        ]),
      ),
    );
  }

  Future<void> _onSubmitted(
    ResetPasswordRequestSubmitted event,
    Emitter<ResetPasswordRequestState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.sendResetPasswordRequest(
          email: state.email.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
