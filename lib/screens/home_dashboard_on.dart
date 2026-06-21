import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/providers/bottom_nav_provider.dart';
import 'package:colorsense/providers/user_preferences_provider.dart';
import 'package:colorsense/widgets/bottom_navbar.dart';
import 'package:colorsense/screens/color_identifier_screen.dart';
import 'package:colorsense/screens/detail_warna_screen.dart';
import 'package:colorsense/screens/contrast_checker.dart';
import 'package:colorsense/screens/palet_warna.dart';
import 'package:colorsense/screens/tersimpan.dart';
import 'package:colorsense/screens/pengaturan.dart';
import 'package:colorsense/screens/simulator_cb.dart';

// -----------------------------------------------------------------------------
// 09 - Home Dashboard (Mode ON) | Figma node: 6:20
// -----------------------------------------------------------------------------

class HomeDashboardOnScreen extends ConsumerWidget {
  const HomeDashboardOnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenH,
                  vertical: AppSpacing.screenV,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header Profile ─────────────────────────────────────
                    Row(
                      children: [
                        SvgPicture.asset(
                            'assets/icons/ic_profile_circle.svg',
                            width: 30,
                            height: 30,
                            colorFilter: ColorFilter.mode(context.colors.textPrimary, BlendMode.srcIn),
                          ),
                        const SizedBox(width: 10),
                        Text(
                          ref.watch(userPreferencesProvider).userName.isNotEmpty 
                            ? ref.watch(userPreferencesProvider).userName 
                            : 'User',
                          style: context.textStyles.bodyMedium.copyWith(
                            color: context.colors.textSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // ── Headline ───────────────────────────────────────────
                    Text(
                      'Apa yang ingin kamu kenali?',
                      style: context.textStyles.headlineLarge.copyWith(
                        fontSize: 17,
                        height: 22 / 17,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ── Shortcut Grid ──────────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: _buildShortcutCard(
                            context: context,
                            iconPath: 'assets/icons/ic_camera.svg',
                            title: 'Identifikasi Warna',
                            subtitle: 'Buka Kamera',
                            onTap: () {
                              ref.read(bottomNavIndexProvider.notifier).setIndex(2);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildShortcutCard(
                            context: context,
                            iconPath: 'assets/icons/ic_mask.svg',
                            title: 'Contrast Checker',
                            subtitle: 'Cek Kontras',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ContrastCheckerScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildShortcutCard(
                            context: context,
                            iconPath: 'assets/icons/ic_element4.svg',
                            title: '24+ Palet',
                            subtitle: 'Jelajahi warna',
                            onTap: () {
                              ref.read(bottomNavIndexProvider.notifier).setIndex(1);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildShortcutCard(
                            context: context,
                            iconPath: 'assets/icons/ic_eye.svg',
                            title: 'Simulasi Buta Warna',
                            subtitle: '3 Tipe',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SimulatorCBScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // ── Terakhir Diidentifikasi ────────────────────────────
                    Text(
                      'TERAKHIR DIIDENTIFIKASI',
                      style: context.textStyles.labelXSmall.copyWith(
                        color: context.colors.textLabel,
                        letterSpacing: 1,
                        fontSize: 8,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _buildRecentCard(
                      context: context,
                      color: const Color(0xFF0047AB),
                      title: 'Biru Cobalt',
                      subtitle: '#2980B9 · via Kamera',
                      time: '2m',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailWarnaScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildRecentCard(
                      context: context,
                      color: const Color(0xFF27AE60),
                      title: 'Hijau Emerald',
                      subtitle: '#27AE60 · via Foto',
                      time: '1j',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailWarnaScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutCard({
    required BuildContext context,
    required String iconPath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          color: context.colors.surfaceSecondary,
          border: Border.all(color: context.colors.borderDefault, width: 1.5),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: context.textStyles.labelXSmall.copyWith(
                      color: context.colors.textLabel,
                      fontSize: 8,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: context.textStyles.labelSmall.copyWith(
                      color: context.colors.textPrimary,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentCard({
    required BuildContext context,
    required Color color,
    required String title,
    required String subtitle,
    required String time,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: context.colors.surfaceSecondary,
        border: Border.all(color: context.colors.borderDefault),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textStyles.labelSmall.copyWith(
                    color: context.colors.textMuted,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: context.textStyles.bodySmall.copyWith(
                    color: context.colors.textMuted,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: context.textStyles.bodySmall.copyWith(
              color: context.colors.textMuted,
              fontSize: 8,
            ),
          ),
        ],
      ),
    ),
    );
  }
}
