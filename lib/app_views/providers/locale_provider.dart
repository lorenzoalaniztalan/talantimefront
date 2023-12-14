import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(Locale local) {
    locale =
        local.languageCode == 'es' ? const Locale('es') : const Locale('en');
  }
  late Locale locale;
  void toggleLocale() {
    locale =
        locale.languageCode == 'es' ? const Locale('en') : const Locale('es');
    notifyListeners();
  }
}
