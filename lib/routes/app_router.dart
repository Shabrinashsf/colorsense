import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:colorsense/providers/user_preferences_provider.dart';

import 'package:colorsense/screens/splash/splash_screen.dart';
import 'package:colorsense/screens/onboarding/onboarding_welcome_screen.dart';
import 'package:colorsense/screens/onboarding/pilih_tipe_cb_screen.dart';
import 'package:colorsense/screens/onboarding/tes_ishihara_screen.dart';
import 'package:colorsense/screens/onboarding/hasil_tes_screen.dart';
import 'package:colorsense/screens/onboarding/keparahan_screen.dart';
import 'package:colorsense/screens/onboarding/preferensi_screen.dart';
import 'package:colorsense/screens/onboarding/izin_kamera_screen.dart';
import 'package:colorsense/screens/home/home_dashboard.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final userPrefs = ref.read(userPreferencesProvider);
      final isSplash = state.matchedLocation == '/';
      final isGoingToOnboarding = state.matchedLocation.startsWith('/welcome') || 
                                  state.matchedLocation.startsWith('/pilih-tipe') ||
                                  state.matchedLocation.startsWith('/tes-ishihara') ||
                                  state.matchedLocation.startsWith('/hasil-tes') ||
                                  state.matchedLocation.startsWith('/keparahan') ||
                                  state.matchedLocation.startsWith('/preferensi') ||
                                  state.matchedLocation.startsWith('/izin-kamera');

      if (userPrefs.hasCompletedOnboarding) {
        // If onboarding is complete, they shouldn't be on Splash or Onboarding screens
        if (isSplash || isGoingToOnboarding) return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const OnboardingWelcomeScreen(),
      ),
      GoRoute(
        path: '/pilih-tipe',
        builder: (context, state) => const PilihTipeCbScreen(),
      ),
      GoRoute(
        path: '/tes-ishihara',
        builder: (context, state) => const TesIshiharaScreen(),
      ),
      GoRoute(
        path: '/hasil-tes',
        builder: (context, state) {
          final tipe = state.extra as String? ?? 'Deuteranopia / Protanopia';
          return HasilTesScreen(tipe: tipe);
        },
      ),
      GoRoute(
        path: '/keparahan',
        builder: (context, state) => const KeparahanScreen(),
      ),
      GoRoute(
        path: '/preferensi',
        builder: (context, state) => const PreferensiScreen(),
      ),
      GoRoute(
        path: '/izin-kamera',
        builder: (context, state) => const IzinKameraScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeDashboard(),
      ),
    ],
  );
});
