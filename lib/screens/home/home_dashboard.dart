import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:colorsense/providers/user_preferences_provider.dart';

import 'package:colorsense/screens/home_dashboard_off.dart';
import 'package:colorsense/screens/home_dashboard_on.dart';
import 'package:colorsense/screens/color_identifier_screen.dart';
import 'package:colorsense/screens/palet_warna.dart';
import 'package:colorsense/screens/tersimpan.dart';
import 'package:colorsense/screens/pengaturan.dart';

import 'package:colorsense/widgets/bottom_navbar.dart';
import 'package:colorsense/providers/bottom_nav_provider.dart';

class HomeDashboard extends ConsumerWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If we want to dynamically read filterMode:
    final filterMode = ref.watch(userPreferencesProvider).filterMode;
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final List<Widget> pages = [
      filterMode ? const HomeDashboardOnScreen() : const HomeDashboardOffScreen(),
      const PaletWarnaScreen(),
      const ColorIdentifierScreen(),
      const TersimpanScreen(),
      const PengaturanScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).setIndex(index);
        },
      ),
    );
  }
}
