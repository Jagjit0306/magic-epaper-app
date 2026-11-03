import 'package:flutter/material.dart';
import 'package:magicepaperapp/theme/app_appearance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppearanceProvider with ChangeNotifier {
  static const _themeModeKey = 'appearance_theme_mode';
  static const _accentColorKey = 'appearance_accent_color';

  ThemeMode _themeMode = ThemeMode.light;
  AppAccentColor _accentColor = AppAccentColor.red;

  ThemeMode get themeMode => _themeMode;
  AppAccentColor get accentColor => _accentColor;

  Future<void> loadSaved() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString(_themeModeKey);
      final savedAccent = prefs.getString(_accentColorKey);

      _themeMode =
          savedTheme == ThemeMode.dark.name ? ThemeMode.dark : ThemeMode.light;
      _accentColor = AppAccentColor.values.firstWhere(
        (accent) => accent.name == savedAccent,
        orElse: () => AppAccentColor.red,
      );
      AppAppearance.accentColor = _accentColor.color;
      notifyListeners();
    } catch (error) {
      debugPrint('Error loading appearance settings: $error');
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (_themeMode == themeMode) return;
    _themeMode = themeMode;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeModeKey, themeMode.name);
    } catch (error) {
      debugPrint('Error saving theme mode: $error');
    }
  }

  Future<void> setAccentColor(AppAccentColor accentColor) async {
    if (_accentColor == accentColor) return;
    _accentColor = accentColor;
    AppAppearance.accentColor = accentColor.color;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_accentColorKey, accentColor.name);
    } catch (error) {
      debugPrint('Error saving accent color: $error');
    }
  }
}
