import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/widgets/bottom_navbar.dart';
import 'package:colorsense/screens/home_dashboard_on.dart';
import 'package:colorsense/screens/color_identifier_screen.dart';
import 'package:colorsense/screens/palet_warna.dart';
import 'package:colorsense/screens/tersimpan.dart';
import 'package:colorsense/screens/filter_mode.dart';
import 'package:colorsense/screens/settings_light_mode.dart';

// -----------------------------------------------------------------------------
// 18 - Pengaturan | Figma node: 12:311
// -----------------------------------------------------------------------------

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({super.key});

  @override
  State<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreen> {
  bool _isLabelWarnaOtomatisOn = true;
  bool _isTTSOn = false;

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
                    // ── Header ─────────────────────────────────────────────
                    Text(
                      'Pengaturan',
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ── Profile Card ───────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSecondary,
                        border: Border.all(color: const Color(0xFF1E1E30)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/ic_profile_circle.svg',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ama',
                                  style: AppTextStyles.headlineMedium.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  'Bio',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: const Color(0xFFAFADDF),
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Edit',
                            style: AppTextStyles.labelMedium.copyWith(
                              color: const Color(0xFF6C63FF),
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ── Aksesibilitas ──────────────────────────────────────
                    _buildSectionTitle('AKSESIBILITAS'),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSecondary,
                        border: Border.all(color: const Color(0xFF1E1E30)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            title: 'Tipe Buta Warna',
                            trailingText: 'Deuteranopia - Sedang',
                            onTap: () {
                              // TODO: Navigate to 22 Keparahan Settings
                            },
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            title: 'Mode Filter',
                            trailingText: 'Default - Dark Accent',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FilterModeScreen(),
                                ),
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildSwitchItem(
                            title: 'Label Warna Otomatis',
                            value: _isLabelWarnaOtomatisOn,
                            onChanged: (val) {
                              setState(() {
                                _isLabelWarnaOtomatisOn = val;
                              });
                            },
                          ),
                          _buildDivider(),
                          _buildSwitchItem(
                            title: 'Text-to-Speech (TTS)',
                            value: _isTTSOn,
                            onChanged: (val) {
                              setState(() {
                                _isTTSOn = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ── Tampilan ───────────────────────────────────────────
                    _buildSectionTitle('TAMPILAN'),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSecondary,
                        border: Border.all(color: const Color(0xFF1E1E30)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          _buildMenuIconItem(
                            title: 'Tema',
                            iconPath: 'assets/icons/ic_moon.svg', // Assumed moon icon path
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsLightModeScreen(),
                                ),
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            title: 'Ukuran Teks',
                            trailingText: 'Normal',
                            onTap: () {
                              // TODO: Navigate to 21 Ukuran Teks
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ── Lainnya ────────────────────────────────────────────
                    _buildSectionTitle('LAINNYA'),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSecondary,
                        border: Border.all(color: const Color(0xFF1E1E30)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _buildMenuItem(
                        title: 'Tentang ColorSense',
                        trailingText: 'v1.0',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom Navbar ──────────────────────────────────────────────
            BottomNavbar(
              currentIndex: 4, // Setting is index 4
              onTap: (index) {
                if (index == 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeDashboardOnScreen(),
                    ),
                    (route) => false,
                  );
                } else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaletWarnaScreen(),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ColorIdentifierScreen(),
                    ),
                  );
                } else if (index == 3) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TersimpanScreen(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: AppTextStyles.labelMedium.copyWith(
          color: const Color(0xFF9D97FF),
          fontSize: 8,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFF1E1E30),
      indent: 10,
      endIndent: 10,
    );
  }

  Widget _buildMenuItem({
    required String title,
    required String trailingText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                color: const Color(0xFFD0D0F0),
                fontSize: 10,
              ),
            ),
            Text(
              trailingText,
              style: AppTextStyles.bodySmall.copyWith(
                color: const Color(0xFFAFADDF),
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuIconItem({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                color: const Color(0xFFD0D0F0),
                fontSize: 10,
              ),
            ),
            SvgPicture.asset(
              iconPath,
              width: 14,
              colorFilter: const ColorFilter.mode(
                Color(0xFF6C63FF), // moon icon color logic based on figma (vector color #6c63ff in design maybe? let's use primary)
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: const Color(0xFFD0D0F0),
              fontSize: 10,
            ),
          ),
          SizedBox(
            height: 20,
            width: 36,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Switch(
                value: value,
                onChanged: onChanged,
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF6C63FF),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: const Color(0xFF1E1E30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
