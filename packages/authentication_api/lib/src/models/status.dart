/// Possible states of a user
enum AuthenticationStatus {
  ///
  unknown,

  /// The user has succesfully authenticated
  authenticated,

  /// User authentication failed
  unauthenticated
}
