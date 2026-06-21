import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:colorsense/providers/shared_prefs_provider.dart';

const _themeModeKey = 'app_theme_mode';

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedMode = prefs.getString(_themeModeKey);
    if (savedMode == 'light') return ThemeMode.light;
    if (savedMode == 'dark') return ThemeMode.dark;
    return ThemeMode.dark; // Default
  }

  void setDark() {
    state = ThemeMode.dark;
    _save('dark');
  }

  void setLight() {
    state = ThemeMode.light;
    _save('light');
  }

  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _save(state == ThemeMode.dark ? 'dark' : 'light');
  }

  void _save(String mode) {
    ref.read(sharedPreferencesProvider).setString(_themeModeKey, mode);
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
