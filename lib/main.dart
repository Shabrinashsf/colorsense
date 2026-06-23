import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera/camera.dart';

import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/providers/theme_provider.dart';
import 'package:colorsense/providers/shared_prefs_provider.dart';
import 'package:colorsense/routes/app_router.dart';
import 'package:colorsense/providers/user_preferences_provider.dart';

late List<CameraDescription> globalCameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize local storage & camera
  final sharedPrefs = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  
  globalCameras = [];

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
      ],
      child: const ColorSenseApp(),
    ),
  );
}

class ColorSenseApp extends ConsumerWidget {
  const ColorSenseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(goRouterProvider);
    final userPrefs = ref.watch(userPreferencesProvider);

    return MaterialApp.router(
      title: 'ColorSense',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      builder: (context, child) {
        if (userPrefs.textScale == -1.0) return child!;
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(userPrefs.textScale),
          ),
          child: child!,
        );
      },
    );
  }
}
