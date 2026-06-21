import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// 19 - Simulator CB | Figma node: 13:2
// -----------------------------------------------------------------------------

class SimulatorCBScreen extends StatefulWidget {
  const SimulatorCBScreen({super.key});

  @override
  State<SimulatorCBScreen> createState() => _SimulatorCBScreenState();
}

class _SimulatorCBScreenState extends State<SimulatorCBScreen> {
  int _selectedTypeIndex = 2; // Default to Achromatopsia
  double _severityValue = 0.5; // Default to Sedang

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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Simulasi Buta Warna',
                              style: context.textStyles.headlineMedium.copyWith(
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              'Lihat dari perspektif berbeda',
                              style: context.textStyles.bodySmall.copyWith(
                                color: context.colors.textMuted,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Hasil Simulasi ─────────────────────────────────────
                    _buildSectionTitle('HASIL SIMULASI'),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceSecondary,
                        border: Border.all(color: context.colors.borderDefault),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildColorWheel(
                            title: 'Warna Asli',
                            colors: [
                              Colors.red,
                              Colors.orange,
                              Colors.yellow,
                              Colors.green,
                              Colors.blue,
                              Colors.indigo,
                              Colors.purple,
                              Colors.red,
                            ],
                          ),
                          _buildColorWheel(
                            title: _getTypeName(_selectedTypeIndex),
                            colors: _getSimulatedColors(_selectedTypeIndex),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Tipe Buta Warna ────────────────────────────────────
                    _buildSectionTitle('TIPE BUTA WARNA'),
                    _buildTypeOption(
                      index: 0,
                      title: 'Tritanopia',
                      subtitle: 'Sulit membedakan Biru & Kuning',
                      iconColors: const [Color(0xFF0072B2), Color(0xFFF0E442)],
                    ),
                    const SizedBox(height: 10),
                    _buildTypeOption(
                      index: 1,
                      title: 'Deuteranopia / Protanopia',
                      subtitle: 'Sulit membedakan Merah & Hijau',
                      iconColors: const [Color(0xFFD55E00), Color(0xFF009E73)],
                    ),
                    const SizedBox(height: 10),
                    _buildTypeOption(
                      index: 2,
                      title: 'Achromatopsia',
                      subtitle: 'Tidak bisa melihat warna sama sekali',
                      iconColors: const [Colors.white, Color(0xFF4A4A4A)],
                    ),
                    const SizedBox(height: 20),

                    // ── Tingkat Keparahan ──────────────────────────────────
                    _buildSectionTitle('TINGKAT KEPARAHAN'),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFF00D9A3), // Using solid active track for now
                        inactiveTrackColor: context.colors.borderDefault,
                        thumbColor: AppColors.primary,
                        trackHeight: 5,
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7.0),
                      ),
                      child: Slider(
                        value: _severityValue,
                        onChanged: (val) {
                          setState(() {
                            _severityValue = val;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ringan',
                            style: context.textStyles.bodySmall.copyWith(
                              color: context.colors.textMuted,
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            'Sedang',
                            style: context.textStyles.labelMedium.copyWith(
                              color: context.colors.textLabel,
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            'Berat',
                            style: context.textStyles.bodySmall.copyWith(
                              color: context.colors.textMuted,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom Button ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.screenH, 10, AppSpacing.screenH, 20),
              child: GestureDetector(
                onTap: () {
                  // Handle Share
                },
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Bagikan',
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

  Widget _buildColorWheel({required String title, required List<Color> colors}) {
    return Column(
      children: [
        Container(
          width: 101,
          height: 101,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: colors,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: context.textStyles.headlineMedium.copyWith(
            color: context.colors.textSecondary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildTypeOption({
    required int index,
    required String title,
    required String subtitle,
    required List<Color> iconColors,
  }) {
    final isSelected = index == _selectedTypeIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTypeIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF161531) : AppColors.surfaceSecondary,
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFF1E1E30),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Split circle icon
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: iconColors,
                  stops: const [0.5, 0.5],
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
                    title,
                    style: context.textStyles.headlineMedium.copyWith(
                      color: context.colors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: context.textStyles.bodySmall.copyWith(
                      color: context.colors.textMuted,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
            // Radio button
            Container(
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
          ],
        ),
      ),
    );
  }

  String _getTypeName(int index) {
    switch (index) {
      case 0:
        return 'Tritanopia';
      case 1:
        return 'Deutera/Protanopia';
      case 2:
      default:
        return 'Achromatopsia';
    }
  }

  List<Color> _getSimulatedColors(int index) {
    switch (index) {
      case 0: // Tritanopia
        return [
          const Color(0xFFE93466),
          const Color(0xFFE93466),
          const Color(0xFFF9A8AE),
          const Color(0xFF88C8D2),
          const Color(0xFF1596A9),
          const Color(0xFF1596A9),
          const Color(0xFF1596A9),
          const Color(0xFFE93466),
        ];
      case 1: // Deuteranopia / Protanopia
        return [
          const Color(0xFF91863E),
          const Color(0xFFEAE27E),
          const Color(0xFFEAE27E),
          const Color(0xFFEAE27E),
          const Color(0xFF285698),
          const Color(0xFF285698),
          const Color(0xFF285698),
          const Color(0xFF91863E),
        ];
      case 2: // Achromatopsia
      default:
        return [
          Colors.grey.shade800,
          Colors.grey.shade600,
          Colors.grey.shade400,
          Colors.grey.shade500,
          Colors.grey.shade700,
          Colors.grey.shade900,
          Colors.grey.shade800,
          Colors.grey.shade800,
        ];
    }
  }
}
