import 'package:flutter/material.dart' show ThemeMode;

import 'package:shared_preferences/shared_preferences.dart';

/// The user's settings.
class Settings {
  static const String _themeModeKey = 'theme-mode';
  static final Map<String, ThemeMode> _themeModes = ThemeMode.values.asNameMap();

  final SharedPreferencesWithCache? _prefs;

  /// Loads the persisted settings.
  static Future<Settings> load() async {
    try {
      return Settings._(
        await SharedPreferencesWithCache.create(cacheOptions: const SharedPreferencesWithCacheOptions()),
      );
    } on Object {
      return const .none();
    }
  }

  const Settings.none() : _prefs = null;

  const Settings._(this._prefs);

  ThemeMode get themeMode => _themeModes[_prefs?.getString(_themeModeKey)] ?? .system;

  set themeMode(ThemeMode mode) {
    _prefs?.setString(_themeModeKey, mode.name);
  }
}
