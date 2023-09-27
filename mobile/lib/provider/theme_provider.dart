import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static final themeNotifier = ValueNotifier(false);

  static String darkTheme = 'darkTheme';

  static Future<bool?> getDarkTheme() async {
    final s = await SharedPreferences.getInstance();
    return s.getBool(darkTheme) ?? false;
  }

  static Future<bool?> saveDarkTheme(bool value) async {
    final s = await SharedPreferences.getInstance();
    return s.setBool(darkTheme, value);
  }

  Future<void> setAppTheme() async {
    bool? value = await ThemeProvider.getDarkTheme();
    ThemeProvider.themeNotifier.value = value!;
    notifyListeners();
  }
}
