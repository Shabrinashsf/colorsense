import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/screens/home_dashboard_off.dart';

// -----------------------------------------------------------------------------
// 08 - Izin Kamera  |  Figma node: 6:2
// -----------------------------------------------------------------------------

class IzinKameraScreen extends StatelessWidget {
  const IzinKameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenH,
            vertical: 20, // slightly less padding for bottom as per Figma
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // ── Camera Icon ─────────────────────────────────────────
              SizedBox(
                width: 72,
                height: 72,
                child: SvgPicture.asset('assets/icons/ic_camera_circle.svg'),
              ),

              const SizedBox(height: 24),

              // ── Headline ─────────────────────────────────────────────
              Text(
                'Izinkan Akses Kamera',
                textAlign: TextAlign.center,
                style: context.textStyles.headlineLarge.copyWith(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 12),

              // ── Sub-headline ─────────────────────────────────────────
              Text(
                'ColorSense membutuhkan izin akses kamera untuk mengidentifikasi warna secara real-time. Tidak ada foto yang disimpan tanpa persetujuanmu.',
                textAlign: TextAlign.center,
                style: context.textStyles.bodyMedium.copyWith(
                  fontSize: 10,
                  height: 17 / 10,
                  color: context.colors.textMuted,
                ),
              ),

              const SizedBox(height: 32),

              // ── Info Box ─────────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10, // keeping some right padding
                  top: 10,
                  bottom: 11,
                ),
                decoration: BoxDecoration(
                  color: context.colors.surfaceSecondary,
                  border: Border.all(color: context.colors.borderDefault),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KAMERA DIGUNAKAN UNTUK',
                      style: context.textStyles.labelXSmall.copyWith(
                        color: context.colors.textLabel,
                        letterSpacing: 1,
                        fontSize: 8,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildBulletPoint(context, 'Identifikasi warna objek real-time'),
                    _buildBulletPoint(context, 'Terapkan filter aksesibilitas live'),
                    _buildBulletPoint(context, 'Scan foto dari galeri (opsional)', isLast: true),
                  ],
                ),
              ),

              const Spacer(),

              // ── Primary Button ───────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to 10 - Home Dashboard (Mode OFF) by default
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const HomeDashboardOffScreen(),
                      ),
                      (route) => false, // Remove all previous routes since Onboarding is done
                    );
                  },
                  child: const Text('Izinkan Akses Kamera'),
                ),
              ),

              const SizedBox(height: 16),

              // ── Text Button ──────────────────────────────────────────
              GestureDetector(
                onTap: () {
                  // Navigate to 10 - Home Dashboard (Mode OFF) by default
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const HomeDashboardOffScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Tidak sekarang',
                    style: context.textStyles.bodyMedium.copyWith(
                      fontSize: 10,
                      color: context.colors.textLabel,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 6, left: 5),
            child: Icon(
              Icons.circle,
              size: 4,
              color: context.colors.textMuted,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: context.textStyles.bodyMedium.copyWith(
                fontSize: 10,
                color: context.colors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
