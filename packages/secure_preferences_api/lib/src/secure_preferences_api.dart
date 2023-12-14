import 'package:preferences_api/preferences_api.dart';
import 'package:secure_preferences_api/secure_preferences_api.dart';

/// {@template secure_preferences_api}
/// A flutter implementation of preferences_api using flutter_secure_storage
/// {@endtemplate}
class SecurePreferencesApi extends PreferencesApi {
  /// {@macro secure_preferences_api}
  const SecurePreferencesApi({required FlutterSecureStorage client})
      : _client = client;

  final FlutterSecureStorage _client;

  @override
  Future<bool> isFirstLogin() async {
    final value = await _client.read(key: 'firstLogin') ?? 'true';
    return value == 'true';
  }

  @override
  Future<void> setFirstLogin() =>
      _client.write(key: 'firstLogin', value: 'false');
}
