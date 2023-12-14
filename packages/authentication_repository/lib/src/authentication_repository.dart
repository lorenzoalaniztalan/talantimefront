import 'dart:async';

import 'package:authentication_api/authentication_api.dart';

/// {@template authentication_repository}
/// Dart package which manages the authentication domain.
/// {@endtemplate}
class AuthenticationRepository {
  ///
  AuthenticationRepository({
    required AuthenticationApi authenticationApi,
    required this.onReceivedTokenCallback,
  }) : _authenticationApi = authenticationApi;

  final AuthenticationApi _authenticationApi;
  final Future<void> Function(String? token) onReceivedTokenCallback;
  final _controller = StreamController<AuthenticationStatus>();

  /// Live update of the user status
  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  /// Login service
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final res =
        await _authenticationApi.logIn(email: email, password: password);
    await onReceivedTokenCallback(res.data['access_token'] as String?);
    _controller.add(AuthenticationStatus.authenticated);
  }

  /// Register
  Future<void> register({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String officeCode,
    required DateTime registrationDate,
    required String employeeId,
  }) async {
    await _authenticationApi.register(
      firstname: firstname,
      lastname: lastname,
      email: email,
      password: password,
      officeCode: officeCode,
      registrationDate: registrationDate,
      employeeId: employeeId,
    );
  }

  /// Logout service
  Future<void> logOut() async {
    await _authenticationApi.logOut();
    await onReceivedTokenCallback(null);
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  /// Disposing the controller
  void dispose() => _controller.close();

  /// Verifies the given email address
  Future<void> verifyUserEmail({
    required String email,
    required String code,
  }) =>
      _authenticationApi.verifyUserEmail(email: email, code: code);

  /// Sends a request to reset a user's password
  Future<void> sendResetPasswordRequest({
    required String email,
  }) async {
    await onReceivedTokenCallback(null);
    return _authenticationApi.sendResetPasswordRequest(
      email: email,
    );
  }

  /// Sends a new password to replace the old password
  Future<void> resetPassword({
    required String email,
    required String password,
    required String token,
  }) =>
      _authenticationApi.resetPassword(
        email: email,
        password: password,
        token: token,
      );
}
