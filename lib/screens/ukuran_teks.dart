import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/providers/user_preferences_provider.dart';

// -----------------------------------------------------------------------------
// 21 - Ukuran Teks | Figma node: 13:85
// -----------------------------------------------------------------------------

class UkuranTeksScreen extends ConsumerStatefulWidget {
  const UkuranTeksScreen({super.key});

  @override
  ConsumerState<UkuranTeksScreen> createState() => _UkuranTeksScreenState();
}

class _UkuranTeksScreenState extends ConsumerState<UkuranTeksScreen> {
  int _selectedSizeIndex = 1; // Default to Normal
  bool _ikutiSistem = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userPrefs = ref.read(userPreferencesProvider);
      setState(() {
        if (userPrefs.textScale == -1.0) {
          _ikutiSistem = true;
          _selectedSizeIndex = 1; // visual default
        } else if (userPrefs.textScale == 0.8) {
          _selectedSizeIndex = 0;
        } else if (userPrefs.textScale == 1.2) {
          _selectedSizeIndex = 2;
        } else if (userPrefs.textScale == 1.4) {
          _selectedSizeIndex = 3;
        } else {
          _selectedSizeIndex = 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    // ── Header ─────────────────────────────────────────────
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(
                              'assets/icons/ic_arrow_left_circle.svg',
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                context.colors.textPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ukuran Teks',
                                style: context.textStyles.headlineMedium.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                'Perubahan langsung diterapkan ke seluruh aplikasi.',
                                style: context.textStyles.bodySmall.copyWith(
                                  color: context.colors.textMuted,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Preview Box ────────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceSecondary,
                        border: Border.all(color: context.colors.borderDefault),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Biru Cobalt',
                            style: context.textStyles.headlineLarge.copyWith(
                              fontSize: 18,
                              color: context.colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '#2980B9 · RGB(41,128,185)',
                            style: context.textStyles.bodyMedium.copyWith(
                              fontSize: 12,
                              color: context.colors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '"Seperti langit cerah di siang hari"',
                            style: context.textStyles.bodySmall.copyWith(
                              fontSize: 10,
                              color: context.colors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Pilih Ukuran ───────────────────────────────────────
                    Text(
                      'PILIH UKURAN',
                      style: context.textStyles.labelMedium.copyWith(
                        color: context.colors.textLabel,
                        fontSize: 8,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 5),

                    _buildSizeOption(
                      index: 0,
                      label: 'A — Kecil',
                      desc: 'Lebih banyak konten',
                      iconSize: 10,
                    ),
                    const SizedBox(height: 7),
                    _buildSizeOption(
                      index: 1,
                      label: 'A — Normal',
                      desc: 'Default',
                      iconSize: 13,
                    ),
                    const SizedBox(height: 7),
                    _buildSizeOption(
                      index: 2,
                      label: 'A — Besar',
                      desc: 'Lebih mudah dibaca',
                      iconSize: 16,
                    ),
                    const SizedBox(height: 7),
                    _buildSizeOption(
                      index: 3,
                      label: 'A — Sangat Besar',
                      desc: 'Low vision',
                      iconSize: 19,
                    ),
                    
                    const SizedBox(height: 7),
                    Divider(
                      color: context.colors.borderDefault,
                      thickness: 1,
                      height: 1,
                    ),
                    const SizedBox(height: 7),

                    // ── Ikuti Sistem ───────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceSecondary,
                        border: Border.all(color: context.colors.borderDefault),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ikuti Ukuran Sistem',
                                  style: context.textStyles.headlineMedium.copyWith(
                                    color: context.colors.textSecondary,
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Gunakan ukuran dari pengaturan HP',
                                  style: context.textStyles.bodySmall.copyWith(
                                    color: context.colors.textMuted,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            width: 36,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Switch(
                                value: _ikutiSistem,
                                onChanged: (val) {
                                  setState(() {
                                    _ikutiSistem = val;
                                  });
                                },
                                activeThumbColor: Colors.white,
                                activeTrackColor: const Color(0xFF6C63FF),
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: context.colors.borderDefault,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Simpan Button ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.screenH, 10, AppSpacing.screenH, 20),
              child: GestureDetector(
                onTap: () {
                  double scale;
                  if (_ikutiSistem) {
                    scale = -1.0;
                  } else {
                    switch (_selectedSizeIndex) {
                      case 0: scale = 0.8; break;
                      case 1: scale = 1.0; break;
                      case 2: scale = 1.2; break;
                      case 3: scale = 1.4; break;
                      default: scale = 1.0; break;
                    }
                  }
                  ref.read(userPreferencesProvider.notifier).setTextScale(scale);
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Simpan Perubahan',
                    style: context.textStyles.labelLarge.copyWith(
                      color: context.colors.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeOption({
    required int index,
    required String label,
    required String desc,
    required double iconSize,
  }) {
    final isSelected = index == _selectedSizeIndex;
    final bgColor = isSelected ? const Color(0x146C63FF) : AppColors.surfaceSecondary; // 0.08 opacity of #6C63FF
    final borderColor = isSelected ? const Color(0x736C63FF) : const Color(0xFF1E1E30); // 0.45 opacity of #6C63FF
    final textColor = isSelected ? const Color(0xFF9D97FF) : const Color(0xFFD0D0F0);

    return GestureDetector(
      onTap: _ikutiSistem ? null : () {
        setState(() {
          _selectedSizeIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 25,
              child: Text(
                'A',
                textAlign: TextAlign.center,
                style: context.textStyles.headlineLarge.copyWith(
                  color: textColor,
                  fontSize: iconSize,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.textStyles.headlineMedium.copyWith(
                      color: textColor,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    desc,
                    style: context.textStyles.bodySmall.copyWith(
                      color: context.colors.textMuted,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
