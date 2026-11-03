import 'package:flutter/material.dart';
import 'package:magicepaperapp/constants/color_constants.dart';
import 'package:magicepaperapp/constants/dimens.dart';
import 'package:magicepaperapp/l10n/app_localizations.dart';
import 'package:magicepaperapp/provider/locale_provider.dart';
import 'package:magicepaperapp/provider/developer_options_provider.dart';
import 'package:magicepaperapp/provider/appearance_provider.dart';
import 'package:provider/provider.dart';
import 'package:magicepaperapp/utils/orientation_util.dart';
import 'package:magicepaperapp/view/widgets/common_scaffold_widget.dart';
import 'package:magicepaperapp/theme/app_appearance.dart';

import '../card_templates/card_template_selection_view.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    setPortraitOrientation();
    super.initState();
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'hi':
        return appLocalizations.hindi;
      case 'en':
      default:
        return appLocalizations.english;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final developerOptionsProvider =
        Provider.of<DeveloperOptionsProvider>(context);
    final appearanceProvider = Provider.of<AppearanceProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return CommonScaffold(
      index: 4,
      title: appLocalizations.appName,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimens.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.language,
              style: TextStyle(
                fontSize: Dimens.fontSizeL,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: Dimens.spacingS),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(Dimens.radiusM),
              ),
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingM),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Locale>(
                  value: localeProvider.locale,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: mdGrey400),
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      localeProvider.setLocale(newLocale);
                    }
                  },
                  items: [
                    DropdownMenuItem<Locale>(
                      value: const Locale('en'),
                      child: Text(
                        _getLanguageName(const Locale('en')),
                        style: TextStyle(color: colorScheme.onSurface),
                      ),
                    ),
                    DropdownMenuItem<Locale>(
                      value: const Locale('hi'),
                      child: Text(
                        _getLanguageName(const Locale('hi')),
                        style: TextStyle(color: colorScheme.onSurface),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Dimens.spacingXl),
            Text(
              appLocalizations.appearance,
              style: TextStyle(
                fontSize: Dimens.fontSizeL,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: Dimens.spacingS),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(Dimens.radiusM),
              ),
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingM),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ThemeMode>(
                  value: appearanceProvider.themeMode,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: mdGrey400),
                  onChanged: (ThemeMode? mode) {
                    if (mode != null) {
                      appearanceProvider.setThemeMode(mode);
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(appLocalizations.lightTheme),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(appLocalizations.darkTheme),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Dimens.spacingMd),
            Text(
              appLocalizations.accentColor,
              style: TextStyle(
                fontSize: Dimens.fontSizeL,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: Dimens.spacingS),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(Dimens.radiusM),
              ),
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingM),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<AppAccentColor>(
                  value: appearanceProvider.accentColor,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: mdGrey400),
                  onChanged: (AppAccentColor? accent) {
                    if (accent != null) {
                      appearanceProvider.setAccentColor(accent);
                    }
                  },
                  items: AppAccentColor.values.map((accent) {
                    return DropdownMenuItem(
                      value: accent,
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: accent.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: Dimens.spacingM),
                          Text(switch (accent) {
                            AppAccentColor.red => appLocalizations.red,
                            AppAccentColor.blue => appLocalizations.blue,
                            AppAccentColor.green => appLocalizations.green,
                            AppAccentColor.purple => appLocalizations.purple,
                            AppAccentColor.orange => appLocalizations.orange,
                          }),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: Dimens.spacingXl),
            Text(
              appLocalizations.developerOptions,
              style: TextStyle(
                fontSize: Dimens.fontSizeL,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: Dimens.spacingS),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(Dimens.radiusM),
              ),
              child: SwitchListTile(
                value: developerOptionsProvider.enabled,
                onChanged: developerOptionsProvider.setEnabled,
                activeThumbColor: colorAccent,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: Dimens.spacingM),
                title: Text(
                  appLocalizations.developerOptions,
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                subtitle: Text(
                  appLocalizations.developerOptionsSubtitle,
                  style: const TextStyle(color: grey600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
