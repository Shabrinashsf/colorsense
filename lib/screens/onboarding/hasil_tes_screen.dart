import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// 05 - Hasil Tes  |  Figma node: 4:93
// -----------------------------------------------------------------------------

class HasilTesScreen extends StatelessWidget {
  final String tipe;

  const HasilTesScreen({
    super.key,
    this.tipe = 'Deuteranopia/Protanopia',
  });

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: AppColors.backgroundPrimary,
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
                  style: AppTextStyles.labelXSmall.copyWith(
                    color: const Color(0xFF9D97FF),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ── Headline ─────────────────────────────────────────────
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineLarge.copyWith(
                  fontSize: 20,
                  height: 28 / 20,
                ),
              ),

              const SizedBox(height: 10),

              // ── Sub-headline ─────────────────────────────────────────
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 11,
                    height: 17 / 11,
                    color: const Color(0xFFAFADDF),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  border: Border.all(color: const Color(0xFF1E1E30)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SKOR PER WARNA',
                      style: AppTextStyles.labelXSmall.copyWith(
                        color: const Color(0xFF9D97FF),
                        letterSpacing: 1,
                        fontSize: 8,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildScoreRow(
                      'Merah-Hijau',
                      80,
                      'Sulit',
                      const Color(0xFFFF6B6B),
                    ),
                    const SizedBox(height: 10),
                    _buildScoreRow(
                      'Biru-Kuning',
                      15,
                      'Normal',
                      const Color(0xFF00D9A3),
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
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 10,
                          color: const Color(0xFFAFADDF),
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
                  Navigator.of(context).pop(); // Go back to test
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tes ulang',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 11,
                      color: const Color(0xFF9D97FF),
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
                    // TODO: Navigate to 06 - Keparahan
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

  Widget _buildScoreRow(String label, int percentage, String status, Color color) {
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
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 9,
              color: const Color(0xFF9090B0),
            ),
          ),
        ),
        SizedBox(
          width: 25,
          child: Text(
            '$percentage%',
            style: AppTextStyles.labelXSmall.copyWith(
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
                  color: Colors.white.withValues(alpha: 0.06),
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
            style: AppTextStyles.labelXSmall.copyWith(
              fontSize: 8,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
