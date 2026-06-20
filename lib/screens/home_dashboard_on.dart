import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/widgets/bottom_navbar.dart';
import 'package:colorsense/screens/color_identifier_screen.dart';

// -----------------------------------------------------------------------------
// 09 - Home Dashboard (Mode ON) | Figma node: 6:20
// -----------------------------------------------------------------------------

class HomeDashboardOnScreen extends StatefulWidget {
  const HomeDashboardOnScreen({super.key});

  @override
  State<HomeDashboardOnScreen> createState() => _HomeDashboardOnScreenState();
}

class _HomeDashboardOnScreenState extends State<HomeDashboardOnScreen> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
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
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Ama',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: const Color(0xFFD0D0F0),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // ── Headline ───────────────────────────────────────────
                    Text(
                      'Apa yang ingin kamu kenali?',
                      style: AppTextStyles.headlineLarge.copyWith(
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
                            iconPath: 'assets/icons/ic_camera.svg',
                            title: 'Identifikasi Warna',
                            subtitle: 'Buka Kamera',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ColorIdentifierScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildShortcutCard(
                            iconPath: 'assets/icons/ic_mask.svg',
                            title: 'Contrast Checker',
                            subtitle: 'Cek Kontras',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildShortcutCard(
                            iconPath: 'assets/icons/ic_element4.svg',
                            title: 'Palet CB-Safe',
                            subtitle: '24+ Palet',
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildShortcutCard(
                            iconPath: 'assets/icons/ic_eye.svg',
                            title: 'Simulasi Buta Warna',
                            subtitle: '3 Tipe',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // ── Terakhir Diidentifikasi ────────────────────────────
                    Text(
                      'TERAKHIR DIIDENTIFIKASI',
                      style: AppTextStyles.labelXSmall.copyWith(
                        color: const Color(0xFF9D97FF),
                        letterSpacing: 1,
                        fontSize: 8,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _buildRecentCard(
                      color: const Color(0xFF2980B9),
                      title: 'Biru Cobalt',
                      subtitle: '#2980B9 · via Kamera',
                      time: '2m',
                    ),
                    const SizedBox(height: 8),
                    _buildRecentCard(
                      color: const Color(0xFF27AE60),
                      title: 'Hijau Emerald',
                      subtitle: '#27AE60 · via Foto',
                      time: '1j',
                    ),
                  ],
                ),
              ),
            ),
            
            // ── Bottom Navbar ──────────────────────────────────────────
            BottomNavbar(
              currentIndex: _bottomNavIndex,
              onTap: (index) {
                setState(() {
                  _bottomNavIndex = index;
                });
                // TODO: Handle tab switching logic later
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutCard({
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
          color: AppColors.surfaceSecondary,
          border: Border.all(color: const Color(0xFF1E1E30), width: 1.5),
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
                    style: AppTextStyles.labelXSmall.copyWith(
                      color: const Color(0xFF9D97FF),
                      fontSize: 8,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: const Color(0xFFF0F0FF),
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
    required Color color,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        border: Border.all(color: const Color(0xFF1E1E30)),
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
                  style: AppTextStyles.labelSmall.copyWith(
                    color: const Color(0xFFC0C0E0),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: const Color(0xFFAFADDF),
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: AppTextStyles.bodySmall.copyWith(
              color: const Color(0xFFAFADDF),
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
