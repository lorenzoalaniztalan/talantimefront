import 'package:preferences_api/preferences_api.dart';

/// {@template preferences_repository}
/// Repository that handles preferences related requests
/// {@endtemplate}
class PreferencesRepository {
  /// {@macro preferences_repository}
  const PreferencesRepository({required PreferencesApi preferencesApi})
      : _preferencesApi = preferencesApi;
  final PreferencesApi _preferencesApi;

  /// Records that the user has entered the app for the first time
  Future<void> setFirstLogin() => _preferencesApi.setFirstLogin();

  /// Is this the very first time the user enters the app?
  Future<bool> isFirstLogin() => _preferencesApi.isFirstLogin();
}
