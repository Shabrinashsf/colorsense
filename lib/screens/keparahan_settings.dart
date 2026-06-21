import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// 22 - Keparahan Settings | Figma node: 13:122
// -----------------------------------------------------------------------------

class KeparahanSettingsScreen extends StatefulWidget {
  const KeparahanSettingsScreen({super.key});

  @override
  State<KeparahanSettingsScreen> createState() => _KeparahanSettingsScreenState();
}

class _KeparahanSettingsScreenState extends State<KeparahanSettingsScreen> {
  int _selectedSeverityIndex = 1; // 0: Ringan, 1: Sedang, 2: Berat

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
                                'Tipe Buta Warna',
                                style: context.textStyles.headlineMedium.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                'Pilih tipe buta warna sesuai dengan kondisimu.',
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

                    // ── Kondisi Sekarang ───────────────────────────────────
                    _buildSectionTitle('KONDISI SEKARANG'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceSecondary,
                        border: Border.all(color: context.colors.borderDefault, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFFD55E00), Color(0xFF009E73)],
                                stops: [0.5, 0.5],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Deuteranopia / Protanopia',
                                  style: context.textStyles.headlineMedium.copyWith(
                                    color: context.colors.textSecondary,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Sulit membedakan Merah & Hijau',
                                  style: context.textStyles.bodySmall.copyWith(
                                    color: context.colors.textMuted,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Tes Ulang',
                            style: context.textStyles.labelMedium.copyWith(
                              color: const Color(0xFF6C63FF),
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Warna Asli ─────────────────────────────────────────
                    _buildSectionTitle('WARNA ASLI'),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC0392B),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'MERAH',
                                style: context.textStyles.headlineMedium.copyWith(
                                  color: context.colors.textMuted,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF27AE60),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'HIJAU',
                                style: context.textStyles.headlineMedium.copyWith(
                                  color: context.colors.textMuted,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Preview ────────────────────────────────────────────
                    _buildSectionTitle('PREVIEW'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildSeverityColumn(
                            index: 0,
                            title: 'RINGAN',
                            titleColor: const Color(0xFF00D9A3),
                            color1: const Color(0xFFB04020),
                            color2: const Color(0xFF708040),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildSeverityColumn(
                            index: 1,
                            title: 'SEDANG',
                            titleColor: const Color(0xFFFFC663),
                            color1: const Color(0xFF987040),
                            color2: const Color(0xFF907848),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildSeverityColumn(
                            index: 2,
                            title: 'BERAT',
                            titleColor: const Color(0xFFFF6B6B),
                            color1: const Color(0xFF8A7A40),
                            color2: const Color(0xFF8A7A40),
                          ),
                        ),
                      ],
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: context.textStyles.labelMedium.copyWith(
          color: context.colors.textLabel,
          fontSize: 8,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildSeverityColumn({
    required int index,
    required String title,
    required Color titleColor,
    required Color color1,
    required Color color2,
  }) {
    final isSelected = _selectedSeverityIndex == index;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textStyles.headlineMedium.copyWith(
                  color: titleColor,
                  fontSize: 8,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedSeverityIndex = index;
            });
          },
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.primary : Colors.transparent,
              border: Border.all(
                color: isSelected ? AppColors.primary : const Color(0xFF1E1E30),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
