part of 'preferences_bloc.dart';

sealed class PreferencesEvent {
  const PreferencesEvent();
}

final class PreferencesSetFirstLogin extends PreferencesEvent {
  const PreferencesSetFirstLogin();
}

final class PreferencesFetchFirstLogin extends PreferencesEvent {
  const PreferencesFetchFirstLogin();
}
