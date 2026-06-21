import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/widgets/step_indicator.dart';
import 'package:colorsense/providers/user_preferences_provider.dart';

// -----------------------------------------------------------------------------
// 06 - Keparahan  |  Figma node: 4:119
// -----------------------------------------------------------------------------

class KeparahanScreen extends ConsumerStatefulWidget {
  const KeparahanScreen({super.key});

  @override
  ConsumerState<KeparahanScreen> createState() => _KeparahanScreenState();
}

class _KeparahanScreenState extends ConsumerState<KeparahanScreen> {
  // Severity selection: 0 = Ringan, 1 = Sedang, 2 = Berat
  int _selectedIndex = -1; // Default no selection

  @override
  Widget build(BuildContext context) {
    final userPrefs = ref.watch(userPreferencesProvider);
    final isTritanopia = userPrefs.cbType == 'Tritanopia';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenH, // 20
            vertical: AppSpacing.screenV,   // 40
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ── Step Indicator ───────────────────────────────────────
              const Center(
                child: StepIndicator(currentStep: 3),
              ),

              const SizedBox(height: 40),

              // ── Headline ─────────────────────────────────────────────
              Text(
                'Tingkat keparahan\nkondisimu',
                style: context.textStyles.headlineLarge.copyWith(
                  height: 30 / 24,
                ),
              ),

              const SizedBox(height: 12),

              // ── Sub-headline ─────────────────────────────────────────
              Text(
                'Fitur ini akan menentukan intensitas filter yang akan diterapkan.',
                style: context.textStyles.bodyMedium.copyWith(
                  fontSize: 11,
                  height: 17 / 11,
                ),
              ),

              const SizedBox(height: 32),

              // ── WARNA ASLI ───────────────────────────────────────────
              Text(
                'WARNA ASLI',
                style: context.textStyles.labelXSmall.copyWith(
                  color: context.colors.textLabel,
                  letterSpacing: 1,
                  fontSize: 8,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: isTritanopia ? const Color(0xFF3498DB) : const Color(0xFFC0392B), // Biru atau Merah
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isTritanopia ? 'BIRU' : 'MERAH',
                          style: context.textStyles.labelXSmall.copyWith(
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
                            color: isTritanopia ? const Color(0xFFF1C40F) : const Color(0xFF27AE60), // Kuning atau Hijau
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isTritanopia ? 'KUNING' : 'HIJAU',
                          style: context.textStyles.labelXSmall.copyWith(
                            color: context.colors.textMuted,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ── PREVIEW ──────────────────────────────────────────────
              Text(
                'PREVIEW',
                style: context.textStyles.labelXSmall.copyWith(
                  color: context.colors.textLabel,
                  letterSpacing: 1,
                  fontSize: 8,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPreviewColumn(
                    index: 0,
                    title: 'RINGAN',
                    titleColor: const Color(0xFF00D9A3),
                    color1: isTritanopia ? const Color(0xFF5D8AA8) : const Color(0xFFB04020),
                    color2: isTritanopia ? const Color(0xFFE6C229) : const Color(0xFF708040),
                  ),
                  _buildPreviewColumn(
                    index: 1,
                    title: 'SEDANG',
                    titleColor: const Color(0xFFFFC663),
                    color1: isTritanopia ? const Color(0xFF719B8F) : const Color(0xFF987040),
                    color2: isTritanopia ? const Color(0xFFDDA0DD) : const Color(0xFF907848),
                  ),
                  _buildPreviewColumn(
                    index: 2,
                    title: 'BERAT',
                    titleColor: const Color(0xFFFF6B6B),
                    color1: isTritanopia ? const Color(0xFF40E0D0) : const Color(0xFF8A7A40),
                    color2: isTritanopia ? const Color(0xFFFFC0CB) : const Color(0xFF8A7A40),
                  ),
                ],
              ),

              const Spacer(),

              // ── Primary Button ───────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedIndex == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pilih tingkat keparahan terlebih dahulu.')),
                      );
                      return;
                    }

                    String sev = 'Sedang';
                    if (_selectedIndex == 0) sev = 'Ringan';
                    if (_selectedIndex == 2) sev = 'Berat';
                    ref.read(userPreferencesProvider.notifier).setSeverity(sev);

                    context.push('/preferensi');
                  },
                  child: const Text('Lanjut \u2192'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewColumn({
    required int index,
    required String title,
    required Color titleColor,
    required Color color1,
    required Color color2,
  }) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: context.textStyles.labelXSmall.copyWith(
              color: titleColor,
              fontSize: 8,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                width: 41, // approx half of 86px minus gap
                height: 45,
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 41,
                height: 45,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.primary : Colors.transparent,
              border: Border.all(
                color: isSelected ? AppColors.primary : const Color(0xFF3B368A),
                width: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
