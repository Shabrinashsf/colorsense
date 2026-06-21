import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/widgets/bottom_navbar.dart';
import 'package:colorsense/screens/home_dashboard_on.dart';
import 'package:colorsense/screens/color_identifier_screen.dart';
import 'package:colorsense/screens/palet_warna.dart';
import 'package:colorsense/screens/tersimpan.dart';
import 'package:colorsense/screens/filter_mode.dart';
import 'package:colorsense/screens/ukuran_teks.dart';
import 'package:colorsense/screens/keparahan_settings.dart';
import 'package:colorsense/providers/theme_provider.dart';
import 'package:colorsense/providers/user_preferences_provider.dart';

// -----------------------------------------------------------------------------
// 18 - Pengaturan | Figma node: 12:311
// -----------------------------------------------------------------------------

class PengaturanScreen extends ConsumerStatefulWidget {
  const PengaturanScreen({super.key});

  @override
  ConsumerState<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends ConsumerState<PengaturanScreen> {
  void _showEditProfileDialog() {
    final prefs = ref.read(userPreferencesProvider);
    final controller = TextEditingController(text: prefs.userName);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: context.colors.surfaceSecondary,
          title: Text('Edit Nama', style: context.textStyles.headlineMedium.copyWith(color: context.colors.textPrimary)),
          content: TextField(
            controller: controller,
            style: context.textStyles.bodyMedium.copyWith(color: context.colors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Nama kamu',
              hintStyle: context.textStyles.bodyMedium.copyWith(color: context.colors.textMuted),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.colors.borderDefault)),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Batal', style: TextStyle(color: context.colors.textMuted)),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  ref.read(userPreferencesProvider.notifier).setUserName(controller.text.trim());
                }
                Navigator.pop(ctx);
              },
              child: const Text('Simpan', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        );
      },
    );
  }

  void _updateAccessibility(bool label, bool tts) {
    if (label && tts) {
      ref.read(userPreferencesProvider.notifier).setAccessibilityOption('Keduanya');
    } else if (label) {
      ref.read(userPreferencesProvider.notifier).setAccessibilityOption('Label Warna');
    } else if (tts) {
      ref.read(userPreferencesProvider.notifier).setAccessibilityOption('Text-to-Speech');
    } else {
      ref.read(userPreferencesProvider.notifier).setAccessibilityOption('Tidak Ada');
    }
  }

  void _showThemeSelector() {
    final currentMode = ref.read(themeModeProvider);
    final colors = context.colors;

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surfaceSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.borderDefault,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Pilih Tema',
                style: context.textStyles.headlineMedium.copyWith(
                  fontSize: 14,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tema berlaku untuk seluruh aplikasi.',
                style: context.textStyles.bodySmall.copyWith(
                  color: colors.textMuted,
                  fontSize: 9,
                ),
              ),
              const SizedBox(height: 16),
              _ThemeOption(
                label: 'Tema Gelap',
                icon: Icons.dark_mode_rounded,
                isSelected: currentMode == ThemeMode.dark,
                onTap: () {
                  ref.read(themeModeProvider.notifier).setDark();
                  Navigator.pop(ctx);
                },
              ),
              const SizedBox(height: 8),
              _ThemeOption(
                label: 'Tema Terang',
                icon: Icons.light_mode_rounded,
                isSelected: currentMode == ThemeMode.light,
                onTap: () {
                  ref.read(themeModeProvider.notifier).setLight();
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final themeMode = ref.watch(themeModeProvider);
    final userPrefs = ref.watch(userPreferencesProvider);
    final themeLabel = themeMode == ThemeMode.light ? 'Terang' : 'Gelap';
    
    // Sync UI with state
    final String cbTypeStr = userPrefs.cbType.isEmpty ? 'Belum Diatur' : userPrefs.cbType;
    final String severityStr = userPrefs.severity.isEmpty ? '' : ' - ${userPrefs.severity}';
    final String filterModeStr = (userPrefs.filterMode && userPrefs.filterModeName.isNotEmpty) 
        ? userPrefs.filterModeName 
        : 'Nonaktif';
    final bool isLabelWarnaOn = userPrefs.accessibilityOption == 'Label Warna' || userPrefs.accessibilityOption == 'Keduanya';
    final bool isTTSOn = userPrefs.accessibilityOption == 'Text-to-Speech' || userPrefs.accessibilityOption == 'Keduanya';
    
    String textScaleStr = 'Normal';
    if (userPrefs.textScale == -1.0) textScaleStr = 'Ikuti Sistem';
    else if (userPrefs.textScale == 0.8) textScaleStr = 'Kecil';
    else if (userPrefs.textScale == 1.2) textScaleStr = 'Besar';
    else if (userPrefs.textScale == 1.4) textScaleStr = 'Sangat Besar';

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
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
                      style: context.textStyles.headlineLarge.copyWith(
                        fontSize: 17,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ── Profile Card ───────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colors.surfaceSecondary,
                        border: Border.all(color: colors.borderDefault),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/ic_profile_circle.svg',
                            width: 30,
                            height: 30,
                            colorFilter: ColorFilter.mode(context.colors.textPrimary, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userPrefs.userName.isNotEmpty ? userPrefs.userName : 'User',
                                  style: context.textStyles.headlineMedium.copyWith(
                                    fontSize: 12,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  'Bio',
                                  style: context.textStyles.bodySmall.copyWith(
                                    color: colors.textMuted,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: _showEditProfileDialog,
                            child: Text(
                              'Edit',
                              style: context.textStyles.labelMedium.copyWith(
                                color: AppColors.primary,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ── Aksesibilitas ──────────────────────────────────────
                    _buildSectionTitle('AKSESIBILITAS', colors),
                    Container(
                      decoration: BoxDecoration(
                        color: colors.surfaceSecondary,
                        border: Border.all(color: colors.borderDefault),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            title: 'Tipe Buta Warna',
                            trailingText: '$cbTypeStr$severityStr',
                            colors: colors,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const KeparahanSettingsScreen(),
                                ),
                              );
                            },
                          ),
                          _buildDivider(colors),
                          _buildMenuItem(
                            title: 'Mode Filter',
                            trailingText: filterModeStr,
                            colors: colors,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FilterModeScreen(),
                                ),
                              );
                            },
                          ),
                          _buildDivider(colors),
                          _buildSwitchItem(
                            title: 'Label Warna Otomatis',
                            value: isLabelWarnaOn,
                            colors: colors,
                            onChanged: (val) {
                              _updateAccessibility(val, isTTSOn);
                            },
                          ),
                          _buildDivider(colors),
                          _buildSwitchItem(
                            title: 'Text-to-Speech (TTS)',
                            value: isTTSOn,
                            colors: colors,
                            onChanged: (val) {
                              _updateAccessibility(isLabelWarnaOn, val);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ── Tampilan ───────────────────────────────────────────
                    _buildSectionTitle('TAMPILAN', colors),
                    Container(
                      decoration: BoxDecoration(
                        color: colors.surfaceSecondary,
                        border: Border.all(color: colors.borderDefault),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          // Tema – shows bottom sheet to pick Dark/Light
                          _buildMenuItem(
                            title: 'Tema',
                            trailingText: themeLabel,
                            colors: colors,
                            onTap: _showThemeSelector,
                          ),
                          _buildDivider(colors),
                          _buildMenuItem(
                            title: 'Ukuran Teks',
                            trailingText: textScaleStr,
                            colors: colors,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UkuranTeksScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ── Lainnya ────────────────────────────────────────────
                    _buildSectionTitle('LAINNYA', colors),
                    Container(
                      decoration: BoxDecoration(
                        color: colors.surfaceSecondary,
                        border: Border.all(color: colors.borderDefault),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _buildMenuItem(
                        title: 'Tentang ColorSense',
                        trailingText: 'v1.0',
                        colors: colors,
                        onTap: () {},
                      ),
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

  Widget _buildSectionTitle(String title, AppThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: context.textStyles.labelMedium.copyWith(
          color: colors.sectionTitle,
          fontSize: 8,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildDivider(AppThemeColors colors) {
    return Divider(
      height: 1,
      thickness: 1,
      color: colors.borderDefault,
      indent: 10,
      endIndent: 10,
    );
  }

  Widget _buildMenuItem({
    required String title,
    required String trailingText,
    required AppThemeColors colors,
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
              style: context.textStyles.bodySmall.copyWith(
                color: colors.textSecondary,
                fontSize: 10,
              ),
            ),
            Text(
              trailingText,
              style: context.textStyles.bodySmall.copyWith(
                color: colors.textMuted,
                fontSize: 9,
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
    required AppThemeColors colors,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textStyles.bodySmall.copyWith(
              color: colors.textSecondary,
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
                activeTrackColor: AppColors.primary,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: colors.borderDefault,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Theme Option tile (used inside bottom sheet) ──────────────────────────
class _ThemeOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.12) : colors.surfacePrimary,
          border: Border.all(
            color: isSelected ? AppColors.primary : colors.borderDefault,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : colors.textMuted, size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: context.textStyles.bodySmall.copyWith(
                  color: isSelected ? AppColors.primary : colors.textSecondary,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 18),
          ],
        ),
      ),
    );
  }
}
