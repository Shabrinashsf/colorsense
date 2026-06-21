import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/providers/user_preferences_provider.dart';
import 'package:colorsense/screens/onboarding/tes_ishihara_screen.dart';
import 'package:colorsense/screens/keparahan_settings.dart';

// -----------------------------------------------------------------------------
// 05 - Hasil Tes  |  Figma node: 4:93
// -----------------------------------------------------------------------------

class HasilTesScreen extends ConsumerWidget {
  final String tipe;
  final bool isRetake;

  const HasilTesScreen({
    super.key,
    this.tipe = 'Deuteranopia/Protanopia',
    this.isRetake = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine dynamic content based on type (as per requirement)
    String title = 'Terdeteksi: $tipe';
    String descPrefix = 'Kamu kesulitan membedakan warna ';
    String descBold = '';
    String iconPath = 'assets/icons/cb_deutan.svg';
    
    if (tipe == 'Tritanopia') {
      descBold = 'Biru dan Kuning';
      iconPath = 'assets/icons/cb_tritanopia.svg';
    } else if (tipe == 'Deuteranopia/Protanopia') {
      descBold = 'Merah dan Hijau';
      iconPath = 'assets/icons/cb_deutan.svg';
    } else if (tipe == 'Achromatopsia') {
      descPrefix = 'Kamu ';
      descBold = 'tidak bisa melihat warna sama sekali';
      iconPath = 'assets/icons/cb_achroma.svg';
    } else if (tipe == 'Tidak buta warna') {
      title = 'Terdeteksi: Normal';
      descPrefix = 'Kamu ';
      descBold = 'tidak buta warna';
      iconPath = 'assets/icons/ic_close_square.svg';
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenH,
            vertical: AppSpacing.screenV,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // ── Circular Icon ─────────────────────────────────────────
              SizedBox(
                width: 72,
                height: 72,
                child: SvgPicture.asset(
                  iconPath,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 10),

              // ── Top Badge ────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  'HASIL TES BUTA WARNA',
                  style: context.textStyles.labelXSmall.copyWith(
                    color: context.colors.textLabel,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ── Headline ─────────────────────────────────────────────
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.textStyles.headlineLarge.copyWith(
                  fontSize: 20,
                  height: 28 / 20,
                ),
              ),

              const SizedBox(height: 10),

              // ── Sub-headline ─────────────────────────────────────────
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: context.textStyles.bodyMedium.copyWith(
                    fontSize: 11,
                    height: 17 / 11,
                    color: context.colors.textMuted,
                  ),
                  children: [
                    TextSpan(text: descPrefix),
                    TextSpan(
                      text: '\n$descBold',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ── Score Card ───────────────────────────────────────────
              if (tipe != 'Achromatopsia' && tipe != 'Tidak buta warna')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceSecondary,
                    border: Border.all(color: context.colors.borderDefault),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SKOR PER WARNA',
                        style: context.textStyles.labelXSmall.copyWith(
                          color: context.colors.textLabel,
                          letterSpacing: 1,
                          fontSize: 8,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (tipe == 'Tritanopia') ...[
                        _buildScoreRow(
                          context,
                          'Biru-Kuning',
                          80,
                          'Sulit',
                          const Color(0xFF3498DB),
                        ),
                      ] else ...[
                        _buildScoreRow(
                          context,
                          'Merah-Hijau',
                          80,
                          'Sulit',
                          const Color(0xFFFF6B6B),
                        ),
                      ],
                      const SizedBox(height: 10),
                      _buildScoreRow(
                        context,
                        'Lainnya',
                        20,
                        'Normal',
                        const Color(0xFF6C63FF),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 10),

              // ── Info Box ─────────────────────────────────────────────
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Kondisi ${tipe.split('/').first} sudah otomatis diterapkan ke profilmu.',
                        style: context.textStyles.bodyMedium.copyWith(
                          fontSize: 10,
                          color: context.colors.textMuted,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/ic_tick_square.svg',
                      width: 12,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ── Tes Ulang Button ─────────────────────────────────────
              GestureDetector(
                onTap: () {
                  if (isRetake) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TesIshiharaScreen(isRetake: true),
                      ),
                    );
                  } else {
                    context.go('/tes-ishihara');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tes ulang',
                    style: context.textStyles.bodyMedium.copyWith(
                      fontSize: 11,
                      color: context.colors.textLabel,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // ── Primary Button ───────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(userPreferencesProvider.notifier).setCbType(tipe);
                    if (isRetake) {
                      if (tipe == 'Achromatopsia' || tipe == 'Saya tidak buta warna' || tipe == 'Tidak buta warna') {
                        // Pop back to Pengaturan
                        Navigator.pop(context);
                      } else {
                        // PushReplacement to KeparahanSettings to force a new selection
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KeparahanSettingsScreen(),
                          ),
                        );
                      }
                    } else {
                      if (tipe == 'Achromatopsia' || tipe == 'Tidak buta warna') {
                        context.push('/preferensi');
                      } else {
                        context.push('/keparahan');
                      }
                    }
                  },
                  child: const Text('Lanjutkan \u2192'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreRow(BuildContext context, String label, int percentage, String status, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 60, // Fixed width for label to align nicely
          child: Text(
            label,
            style: context.textStyles.bodySmall.copyWith(
              fontSize: 9,
              color: context.colors.textMuted,
            ),
          ),
        ),
        SizedBox(
          width: 25,
          child: Text(
            '$percentage%',
            style: context.textStyles.labelXSmall.copyWith(
              fontSize: 8,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: context.colors.textMuted,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage / 100,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 35,
          child: Text(
            status,
            style: context.textStyles.labelXSmall.copyWith(
              fontSize: 8,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
