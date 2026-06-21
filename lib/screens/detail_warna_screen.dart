import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/providers/saved_colors_provider.dart';

// -----------------------------------------------------------------------------
// 12 - Detail Warna | Figma node: 99:49
// -----------------------------------------------------------------------------

import 'dart:typed_data';

class DetailWarnaScreen extends ConsumerWidget {
  final bool isFromSaved;
  final String colorName;
  final String hexColor;
  final Uint8List? sourceImageBytes;

  const DetailWarnaScreen({
    super.key,
    this.isFromSaved = false,
    this.colorName = 'Biru Cobalt',
    this.hexColor = '#0047AB',
    this.sourceImageBytes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int parsedColorValue = int.tryParse(hexColor.replaceAll('#', '0xFF')) ?? 0xFF0047AB;
    final Color actualColor = Color(parsedColorValue);
    
    // Calculate RGB
    final int r = actualColor.red;
    final int g = actualColor.green;
    final int b = actualColor.blue;
    final String rgbStr = '$r, $g, $b';

    // Calculate HSL
    final hsl = HSLColor.fromColor(actualColor);
    final String hslStr = '${hsl.hue.round()}°, ${(hsl.saturation * 100).round()}%, ${(hsl.lightness * 100).round()}%';

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
                        Text(
                          'Detail Warna',
                          style: context.textStyles.headlineMedium.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // ── Color Header Card ──────────────────────────────────
                    Container(
                      height: 60,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        color: actualColor,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Text(
                        colorName,
                        style: context.textStyles.headlineLarge.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ── Nilai Warna ────────────────────────────────────────
                    Text(
                      'NILAI WARNA',
                      style: context.textStyles.labelXSmall.copyWith(
                        color: context.colors.textLabel,
                        fontSize: 8,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceSecondary,
                        border: Border.all(color: context.colors.borderDefault),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildColorValue(context, label: 'HEX', value: hexColor),
                          _buildColorValue(context, label: 'RGB', value: rgbStr),
                          _buildColorValue(context, label: 'HSL', value: hslStr),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),



                    // ── Tampak Oleh Tipe Buta Warna Lain ───────────────────
                    Text(
                      'TAMPAK OLEH TIPE BUTA WARNA LAIN',
                      style: context.textStyles.labelXSmall.copyWith(
                        color: context.colors.textLabel,
                        fontSize: 8,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceSecondary,
                        border: Border.all(color: context.colors.borderDefault),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Column(
                        children: [
                          _buildSimulationRow(context,
                            color: const Color(0xFF2E5EA1),
                            text: 'Deuteranopia — abu kebiruan',
                          ),
                          const SizedBox(height: 3),
                          _buildSimulationRow(context,
                            color: const Color(0xFF54749F),
                            text: 'Protanopia — tampak biru-hijau',
                          ),
                          const SizedBox(height: 3),
                          _buildSimulationRow(context,
                            color: const Color(0xFF0047AB),
                            text: 'Tritanopia — normal',
                          ),
                          const SizedBox(height: 3),
                          _buildSimulationRow(context,
                            color: const Color(0xFF808080),
                            text: 'Achromatopsia — abu sedang',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),

                    // ── Quote Bubble ───────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceSecondary,
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/ic_message_bubble.svg',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                '"Warna ini seperti laut biru di tengah samudera🌊"',
                                style: context.textStyles.bodySmall.copyWith(
                                  color: context.colors.textMuted,
                                  fontSize: 9,
                                ),
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

            // ── Bottom Action Buttons ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.screenH,
                right: AppSpacing.screenH,
                bottom: 20,
                top: 10,
              ),
              child: Row(
                children: [
                  if (!isFromSaved) ...[
                    // Simpan Button
                    Expanded(
                      flex: 128,
                      child: GestureDetector(
                        onTap: () {
                          ref.read(savedColorsProvider.notifier).saveColor(colorName, hexColor);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Warna disimpan!')),
                          );
                        },
                        child: Container(
                          height: 48, // slightly bigger than Figma 36px for better touch
                          decoration: BoxDecoration(
                            color: context.colors.surfaceSecondary,
                            border: Border.all(color: context.colors.borderDefault),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ic_save.svg',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Simpan',
                                style: context.textStyles.labelMedium.copyWith(
                                  color: context.colors.textPrimary,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],

                  // Bagikan Button
                  Expanded(
                    flex: 143,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Handle bagikan
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_share.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Bagikan',
                              style: context.textStyles.labelMedium.copyWith(
                                color: context.colors.textPrimary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildColorValue(BuildContext context, {required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.textStyles.headlineMedium.copyWith(
            color: context.colors.textSecondary,
            fontSize: 11,
          ),
        ),
        Text(
          label,
          style: context.textStyles.labelSmall.copyWith(
            color: context.colors.textMuted,
            fontSize: 7,
          ),
        ),
      ],
    );
  }

  Widget _buildSimulationRow(BuildContext context, {required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 26,
          height: 9,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: context.textStyles.labelSmall.copyWith(
            color: context.colors.textMuted,
            fontSize: 8,
          ),
        ),
      ],
    );
  }
}
