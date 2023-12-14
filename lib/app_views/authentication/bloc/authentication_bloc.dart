import 'dart:async';

import 'package:authentication_api/authentication_api.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_api/user_api.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationEmailVerified>(_restart);
    on<AuthenticationUserAvatarRequested>(_requestUserAvatar);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : AuthenticationState.unauthenticated(),
        );
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _userRepository.removeUser();
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  void _restart(
    AuthenticationEmailVerified event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(
      AuthenticationState.unknown(),
    );
    add(
      const _AuthenticationStatusChanged(
        AuthenticationStatus.unknown,
      ),
    );
  }

  Future<void> _requestUserAvatar(
    AuthenticationUserAvatarRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(avatarStatus: UserAvatarStatus.loading));
    XFile? photo;
    try {
      final res = await _userRepository.getCurrentUserAvatar();
      photo = XFile.fromData(res);
    } catch (e) {/* TODO: handle error */}
    emit(
      state.copyWith(
        avatarStatus: UserAvatarStatus.initial,
        photo: photo,
        forcePhoto: true,
      ),
    );
  }
}
