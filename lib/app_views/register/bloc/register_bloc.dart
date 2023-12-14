import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:turnotron/app_views/register/models/models.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(
    AuthenticationRepository authenticationRepository,
  )   : _authenticationRepository = authenticationRepository,
        super(RegisterState()) {
    on<RegisterFirstnameChanged>(_onFirstnameChanged);
    on<RegisterLastnameChanged>(_onLastnameChanged);
    on<RegisterEmployeeIdChanged>(_onEmployeeIdChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterOfficeChanged>(_onOfficeChanged);
    on<RegisterRegistrationDateChanged>(_onRegistrationDateChanged);
    on<RegisterSubmitted>(_onSubmitted);
    on<RegisterResetForm>(_onResetForm);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onFirstnameChanged(
    RegisterFirstnameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final firstname = Firstname.dirty(event.firstname);
    emit(
      state.copyWith(
        firstname: firstname,
        isValid: Formz.validate([
          firstname,
          state.lastname,
          state.employeeId,
          state.email,
          state.password,
          state.officeCode,
          state.registrationDate,
        ]),
      ),
    );
  }

  void _onLastnameChanged(
    RegisterLastnameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final lastname = Lastname.dirty(event.lastname);
    emit(
      state.copyWith(
        lastname: lastname,
        isValid: Formz.validate([
          state.firstname,
          lastname,
          state.employeeId,
          state.email,
          state.password,
          state.officeCode,
          state.registrationDate,
        ]),
      ),
    );
  }

  FutureOr<void> _onEmployeeIdChanged(
    RegisterEmployeeIdChanged event,
    Emitter<RegisterState> emit,
  ) {
    final employeeId = EmployeeId.dirty(event.employeeId);
    final password = Password.dirty(event.employeeId);
    emit(
      state.copyWith(
        employeeId: employeeId,
        password: password,
        isValid: Formz.validate([
          state.firstname,
          state.lastname,
          employeeId,
          state.email,
          password,
          state.officeCode,
          state.registrationDate,
        ]),
      ),
    );
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.firstname,
          state.lastname,
          state.employeeId,
          email,
          state.password,
          state.officeCode,
          state.registrationDate,
        ]),
      ),
    );
  }

  void _onOfficeChanged(
    RegisterOfficeChanged event,
    Emitter<RegisterState> emit,
  ) {
    final officeCode = OfficeCode.dirty(event.office);
    emit(
      state.copyWith(
        officeCode: officeCode,
        isValid: Formz.validate([
          state.firstname,
          state.lastname,
          state.employeeId,
          state.email,
          state.password,
          officeCode,
          state.registrationDate,
        ]),
      ),
    );
  }

  void _onRegistrationDateChanged(
    RegisterRegistrationDateChanged event,
    Emitter<RegisterState> emit,
  ) {
    final registrationDate = RegistrationDate.dirty(event.registrationDate);
    emit(
      state.copyWith(
        registrationDate: registrationDate,
        isValid: Formz.validate([
          state.firstname,
          state.lastname,
          state.employeeId,
          state.email,
          state.password,
          state.officeCode,
          registrationDate,
        ]),
      ),
    );
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.register(
          firstname: state.firstname.value,
          lastname: state.lastname.value,
          email: state.email.value,
          password: state.password.value,
          officeCode: state.officeCode.value,
          registrationDate: state.registrationDate.value!,
          employeeId: state.employeeId.value,
        );
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
            responseCode: 200,
          ),
        );
      } catch (e) {
        var errorCode = 400;
        if (e is DioException) {
          errorCode = e.response?.statusCode ?? 400;
        }
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            responseCode: errorCode,
          ),
        );
      }
    }
  }

  void _onResetForm(
    RegisterResetForm event,
    Emitter<RegisterState> emit,
  ) {
    emit(RegisterState());
  }
}
