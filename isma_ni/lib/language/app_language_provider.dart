import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  Locale _appLocale = const Locale("en");

  Locale get appLocal => _appLocale;

  Future<void> fetchLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('language_code');

    if (code == null) {
      _appLocale = const Locale('en');
      return;
    }

    _appLocale = Locale(code);
    notifyListeners();
  }

  Future<void> changeLanguage(Locale type) async {
    final prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) return;

    if (type.languageCode == 'ar') {
      _appLocale = const Locale("ar", "SA");
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', 'SA');
    } else {
      _appLocale = const Locale("en", "US");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
