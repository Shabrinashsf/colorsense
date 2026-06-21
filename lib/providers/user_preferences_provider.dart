import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:colorsense/providers/shared_prefs_provider.dart';

// Keys for SharedPreferences
const _keyHasCompletedOnboarding = 'has_completed_onboarding';
const _keyUserName = 'user_name';
const _keyCbType = 'cb_type';
const _keySeverity = 'cb_severity';
const _keyFilterMode = 'filter_mode'; // true = ON, false = OFF
const _keyFilterModeName = 'filter_mode_name'; // e.g. "High Contrast"
const _keyAccessibilityOption = 'accessibility_option'; // "Label Warna", "Text-to-Speech", "Keduanya"
const _keyTextScale = 'text_scale';

class UserPreferencesState {
  final bool hasCompletedOnboarding;
  final String userName;
  final String cbType;
  final String severity;
  final bool filterMode;
  final String filterModeName;
  final String accessibilityOption;
  final double textScale;

  UserPreferencesState({
    this.hasCompletedOnboarding = false,
    this.userName = '',
    this.cbType = '',
    this.severity = '',
    this.filterMode = false,
    this.filterModeName = '',
    this.accessibilityOption = '',
    this.textScale = 1.0,
  });

  UserPreferencesState copyWith({
    bool? hasCompletedOnboarding,
    String? userName,
    String? cbType,
    String? severity,
    bool? filterMode,
    String? filterModeName,
    String? accessibilityOption,
    double? textScale,
  }) {
    return UserPreferencesState(
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      userName: userName ?? this.userName,
      cbType: cbType ?? this.cbType,
      severity: severity ?? this.severity,
      filterMode: filterMode ?? this.filterMode,
      filterModeName: filterModeName ?? this.filterModeName,
      accessibilityOption: accessibilityOption ?? this.accessibilityOption,
      textScale: textScale ?? this.textScale,
    );
  }
}

class UserPreferencesNotifier extends Notifier<UserPreferencesState> {
  @override
  UserPreferencesState build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return UserPreferencesState(
      hasCompletedOnboarding: prefs.getBool(_keyHasCompletedOnboarding) ?? false,
      userName: prefs.getString(_keyUserName) ?? '',
      cbType: prefs.getString(_keyCbType) ?? '',
      severity: prefs.getString(_keySeverity) ?? '',
      filterMode: prefs.getBool(_keyFilterMode) ?? false,
      filterModeName: prefs.getString(_keyFilterModeName) ?? '',
      accessibilityOption: prefs.getString(_keyAccessibilityOption) ?? '',
      textScale: prefs.getDouble(_keyTextScale) ?? 1.0,
    );
  }

  void completeOnboarding() {
    state = state.copyWith(hasCompletedOnboarding: true);
    ref.read(sharedPreferencesProvider).setBool(_keyHasCompletedOnboarding, true);
  }

  void setUserName(String name) {
    state = state.copyWith(userName: name);
    ref.read(sharedPreferencesProvider).setString(_keyUserName, name);
  }

  void setCbType(String type) {
    state = state.copyWith(cbType: type);
    ref.read(sharedPreferencesProvider).setString(_keyCbType, type);
  }

  void setSeverity(String severity) {
    state = state.copyWith(severity: severity);
    ref.read(sharedPreferencesProvider).setString(_keySeverity, severity);
  }

  void setFilterMode(bool isOn, {String name = ''}) {
    state = state.copyWith(filterMode: isOn, filterModeName: name);
    ref.read(sharedPreferencesProvider).setBool(_keyFilterMode, isOn);
    ref.read(sharedPreferencesProvider).setString(_keyFilterModeName, name);
  }

  void setAccessibilityOption(String option) {
    state = state.copyWith(accessibilityOption: option);
    ref.read(sharedPreferencesProvider).setString(_keyAccessibilityOption, option);
  }

  void setTextScale(double scale) {
    state = state.copyWith(textScale: scale);
    ref.read(sharedPreferencesProvider).setDouble(_keyTextScale, scale);
  }
}

final userPreferencesProvider = NotifierProvider<UserPreferencesNotifier, UserPreferencesState>(UserPreferencesNotifier.new);
