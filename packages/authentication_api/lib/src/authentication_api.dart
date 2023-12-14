/// {@template authentication_api}
/// Interface and models for an API providing authentication related resources.
/// {@endtemplate}
abstract class AuthenticationApi {
  /// {@macro authentication_api}
  const AuthenticationApi();

  /// Authenticates the user against our backend services
  Future<dynamic> logIn({
    required String email,
    required String password,
  });

  /// Registers the user against our backend services
  Future<dynamic> register({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String officeCode,
    required DateTime registrationDate,
    required String employeeId,
  });

  /// Ends the current session
  Future<void> logOut();

  /// Verifies the user confirmed their email
  Future<void> verifyUserEmail({required String email, required String code});

  /// Sends a request to reset a user's password
  Future<void> sendResetPasswordRequest({
    required String email,
  });

  /// Sends a new password to replace the old password
  Future<void> resetPassword({
    required String email,
    required String password,
    required String token,
  });
}
