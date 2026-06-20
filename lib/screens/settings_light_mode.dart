import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/screens/home_dashboard_on.dart';
import 'package:colorsense/screens/color_identifier_screen.dart';
import 'package:colorsense/screens/palet_warna.dart';
import 'package:colorsense/screens/tersimpan.dart';
import 'package:colorsense/screens/pengaturan.dart';

// -----------------------------------------------------------------------------
// 20 - Settings Light Mode | Figma node: 136:972
// -----------------------------------------------------------------------------

class SettingsLightModeScreen extends StatefulWidget {
  const SettingsLightModeScreen({super.key});

  @override
  State<SettingsLightModeScreen> createState() => _SettingsLightModeScreenState();
}

class _SettingsLightModeScreenState extends State<SettingsLightModeScreen> {
  bool _isLabelWarnaOtomatisOn = true;
  bool _isTTSOn = false;

  // Light Mode Colors
  final Color _bgLight = const Color(0xFFF5F5FF);
  final Color _textDark = const Color(0xFF1A1A2E);
  final Color _textGrey = const Color(0xFF8080A0);
  final Color _sectionTitle = const Color(0xFF6C6C75);
  final Color _cardBg = Colors.white;
  final Color _borderColor = const Color(0xFFE0E0F0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
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
                        color: _textDark,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ── Profile Card ───────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _cardBg,
                        border: Border.all(color: _borderColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/ic_profile_circle.svg',
                            width: 30,
                            height: 30,
                            // Profile icon in figma may be dark, but let's assume default asset
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ama',
                                  style: AppTextStyles.headlineMedium.copyWith(
                                    color: _textDark,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  'Bio',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: _textGrey,
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
                        color: _cardBg,
                        border: Border.all(color: _borderColor),
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
                            onTap: () {},
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
                        color: _cardBg,
                        border: Border.all(color: _borderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          _buildMenuIconItem(
                            title: 'Tema',
                            iconPath: 'assets/icons/ic_sun.svg', // Assuming light mode uses sun icon (we can use moon if sun is absent, but design says 'sun')
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PengaturanScreen(),
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
                        color: _cardBg,
                        border: Border.all(color: _borderColor),
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

            // ── Bottom Navbar (Light Mode Theme) ───────────────────────────
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: _bgLight,
                border: Border(
                  top: BorderSide(
                    color: _borderColor,
                    width: 1.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavItem(
                    iconPath: 'assets/icons/ic_home.svg',
                    label: 'Home',
                    isActive: false,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeDashboardOnScreen()),
                        (route) => false,
                      );
                    },
                  ),
                  _buildBottomNavItem(
                    iconPath: 'assets/icons/ic_element4.svg',
                    label: 'Palet',
                    isActive: false,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const PaletWarnaScreen()),
                      );
                    },
                  ),
                  _buildBottomNavItem(
                    iconPath: 'assets/icons/ic_camera.svg',
                    label: 'Kamera',
                    isActive: false,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ColorIdentifierScreen()),
                      );
                    },
                  ),
                  _buildBottomNavItem(
                    iconPath: 'assets/icons/ic_save_outline.svg', // using generic for now
                    label: 'Simpan',
                    isActive: false,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const TersimpanScreen()),
                      );
                    },
                  ),
                  _buildBottomNavItem(
                    iconPath: 'assets/icons/ic_setting.svg',
                    label: 'Setting',
                    isActive: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required String iconPath,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final color = isActive ? AppColors.primary : _textDark;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: color,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: AppTextStyles.labelMedium.copyWith(
          color: _sectionTitle,
          fontSize: 8,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: _borderColor,
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
                color: _textDark,
                fontSize: 10,
              ),
            ),
            Text(
              trailingText,
              style: AppTextStyles.bodySmall.copyWith(
                color: _textGrey,
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
                color: _textDark,
                fontSize: 10,
              ),
            ),
            // Use icon or fallback if not available
            Icon(Icons.wb_sunny_rounded, size: 16, color: AppColors.primary),
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
              color: _textDark,
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
                inactiveTrackColor: const Color(0xFF9898A6), // light mode inactive track
              ),
            ),
          ),
        ],
      ),
    );
  }
}
