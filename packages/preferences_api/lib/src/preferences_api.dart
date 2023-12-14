/// {@template preferences_api}
/// Interface and models for an Api providing user preferences related resources
/// {@endtemplate}
abstract class PreferencesApi {
  /// {@macro preferences_api}
  const PreferencesApi();

  /// Records that the user has entered the app for the first time
  Future<void> setFirstLogin();

  /// Is this the very first time the user enters the app?
  Future<bool> isFirstLogin();
}
