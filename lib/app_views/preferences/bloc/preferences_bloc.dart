import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:preferences_repository/preferences_repository.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesBloc({
    required PreferencesRepository preferencesRepository,
  })  : _preferencesRepository = preferencesRepository,
        super(const PreferencesState()) {
    on<PreferencesSetFirstLogin>(_onSetFirstLogin);
    on<PreferencesFetchFirstLogin>(_onFetchFirstLogin);
  }

  final PreferencesRepository _preferencesRepository;

  Future<void> _onSetFirstLogin(
    PreferencesSetFirstLogin event,
    Emitter<PreferencesState> emit,
  ) async {
    try {
      await _preferencesRepository.setFirstLogin();
    } catch (e) {}
  }

  Future<void> _onFetchFirstLogin(
    PreferencesFetchFirstLogin event,
    Emitter<PreferencesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: PreferencesStatus.loading));
      final res = await _preferencesRepository.isFirstLogin();
      emit(
        state.copyWith(status: PreferencesStatus.initial, isFirstLogin: res),
      );
    } catch (e) {
      state.copyWith(
        status: PreferencesStatus.initial,
      );
    }
  }
}
