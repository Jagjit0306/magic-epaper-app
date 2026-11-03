import 'package:flutter/material.dart';

enum AppAccentColor {
  red(Color(0xFFD32F2F)),
  blue(Color(0xFF1976D2)),
  green(Color(0xFF388E3C)),
  purple(Color(0xFF7B1FA2)),
  orange(Color(0xFFEF6C00));

  const AppAccentColor(this.color);

  final Color color;
}

class AppAppearance {
  AppAppearance._();

  static Color accentColor = AppAccentColor.red.color;
}
