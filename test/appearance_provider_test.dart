import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magicepaperapp/provider/appearance_provider.dart';
import 'package:magicepaperapp/theme/app_appearance.dart';
import 'package:magicepaperapp/theme/app_theme.dart';
import 'package:magicepaperapp/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AppAppearance.accentColor = AppAccentColor.red.color;
  });

  test('uses light mode and red accent by default', () async {
    final provider = AppearanceProvider();

    await provider.loadSaved();

    expect(provider.themeMode, ThemeMode.light);
    expect(provider.accentColor, AppAccentColor.red);
    expect(AppAppearance.accentColor, AppAccentColor.red.color);
    expect(colorAccent, AppAccentColor.red.color);
  });

  test('persists and restores theme and accent selections', () async {
    final provider = AppearanceProvider();
    await provider.loadSaved();

    await provider.setThemeMode(ThemeMode.dark);
    await provider.setAccentColor(AppAccentColor.purple);

    final restoredProvider = AppearanceProvider();
    await restoredProvider.loadSaved();

    expect(restoredProvider.themeMode, ThemeMode.dark);
    expect(restoredProvider.accentColor, AppAccentColor.purple);
    expect(AppAppearance.accentColor, AppAccentColor.purple.color);
    expect(colorAccent, AppAccentColor.purple.color);
    expect(
      AppTheme.darkTheme(AppAccentColor.purple.color).brightness,
      Brightness.dark,
    );
    expect(
      AppTheme.darkTheme(AppAccentColor.purple.color).primaryColor,
      AppAccentColor.purple.color,
    );
  });
}
