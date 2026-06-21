import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// 16 - Detail Palet | Figma node: 12:210
// -----------------------------------------------------------------------------

class DetailPaletScreen extends StatelessWidget {
  const DetailPaletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded Okabe-Ito for UI slicing
    final colors = [
      const Color(0xFFE69F00),
      const Color(0xFF56B4E9),
      const Color(0xFF009E73),
      const Color(0xFFF0E442),
      const Color(0xFF0072B2),
      const Color(0xFFD55E00),
    ];

    final hexCodes = [
      '#E69F00',
      '#56B4E9',
      '#009E73',
      '#F0E442',
      '#0072B2',
      '#D55E00',
    ];

    return Scaffold(
      body: SafeArea(
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
                  Text(
                    'Detail Palet',
                    style: context.textStyles.headlineMedium.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Title & Subtitle ───────────────────────────────────
              Text(
                'Okabe-Ito Palette',
                style: context.textStyles.headlineLarge.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Untuk semua tipe buta warna · 8 warna', // Text from Figma
                style: context.textStyles.bodySmall.copyWith(
                  color: context.colors.textMuted,
                  fontSize: 9,
                ),
              ),
              const SizedBox(height: 20),

              // ── Large Color Strip ──────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(0), // No border radius in design? Wait, design shows no border radius, just a flat strip.
                child: Row(
                  children: colors.map((c) {
                    return Expanded(
                      child: Container(
                        height: 52,
                        color: c,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),

              // ── Hex Grid ───────────────────────────────────────────
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 3.5, // Approx height/width ratio for the chips
                ),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: context.colors.surfaceSecondary,
                      border: Border.all(color: context.colors.borderDefault),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: colors[index],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          hexCodes[index],
                          style: context.textStyles.bodySmall.copyWith(
                            color: context.colors.textMuted,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              // ── Kompatibilitas ─────────────────────────────────────
              Text(
                'KOMPATIBILITAS BUTA WARNA',
                style: context.textStyles.labelXSmall.copyWith(
                  color: context.colors.textLabel,
                  letterSpacing: 0.8,
                  fontSize: 8,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: context.colors.surfaceSecondary,
                  border: Border.all(color: context.colors.borderDefault),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Column(
                  children: [
                    _buildCompatRow(context, 'Deuteranopia / Protanopia', 'AMAN', true),
                    const SizedBox(height: 4),
                    _buildCompatRow(context, 'Tritanopia', 'AMAN', true),
                    const SizedBox(height: 4),
                    _buildCompatRow(context, 'Achromatopsia', 'TERBATAS', false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompatRow(BuildContext context, String title, String status, bool isAman) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textStyles.bodySmall.copyWith(
            color: context.colors.textMuted,
            fontSize: 9,
          ),
        ),
        Container(
          width: 72,
          padding: const EdgeInsets.symmetric(vertical: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isAman
                ? const Color(0xFF00D9A3).withValues(alpha: 0.1)
                : const Color(0xFFFFC663).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            status,
            style: context.textStyles.labelSmall.copyWith(
              color: isAman ? const Color(0xFF00D9A3) : const Color(0xFFFFC663),
              fontSize: 8,
            ),
          ),
        ),
      ],
    );
  }
}
