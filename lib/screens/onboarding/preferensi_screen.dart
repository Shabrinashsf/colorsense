import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/widgets/step_indicator.dart';
import 'package:colorsense/providers/user_preferences_provider.dart';

// -----------------------------------------------------------------------------
// 07 - Preferensi  |  Figma node: 4:154
// -----------------------------------------------------------------------------

class PreferensiScreen extends ConsumerStatefulWidget {
  const PreferensiScreen({super.key});

  @override
  ConsumerState<PreferensiScreen> createState() => _PreferensiScreenState();
}

class _PreferensiScreenState extends ConsumerState<PreferensiScreen> {
  bool _isLabelWarnaActive = false;
  bool _isTtsActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenH,
            vertical: AppSpacing.screenV,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ── Step Indicator ───────────────────────────────────────
              const Center(
                child: StepIndicator(currentStep: 4),
              ),

              const SizedBox(height: 40),

              // ── Headline ─────────────────────────────────────────────
              Text(
                'Atur fitur\ndefaultmu',
                style: context.textStyles.headlineLarge.copyWith(
                  height: 30 / 24,
                ),
              ),

              const SizedBox(height: 12),

              // ── Sub-headline ─────────────────────────────────────────
              Text(
                'Fitur bisa diubah di Settings kapanpun.',
                style: context.textStyles.bodyMedium.copyWith(
                  fontSize: 11,
                  height: 17 / 11,
                ),
              ),

              const SizedBox(height: 32),

              // ── Options ──────────────────────────────────────────────
              _buildPreferenceCard(
                title: 'Label Warna Otomatis',
                subtitle: 'Tampilkan nama warna di viewfinder',
                iconPath: 'assets/icons/ic_tag.svg',
                isActive: _isLabelWarnaActive,
                onChanged: (val) {
                  setState(() {
                    _isLabelWarnaActive = val;
                  });
                },
              ),

              const SizedBox(height: 12),

              _buildPreferenceCard(
                title: 'Text-to-speech',
                subtitle: 'Bacakan nama warna saat terdeteksi',
                iconWidget: SizedBox(
                  width: 24,
                  height: 24,
                  child: Stack(
                    children: [
                      SvgPicture.asset('assets/icons/ic_music_filter.svg'),
                      Positioned(
                        left: 5,
                        top: 6,
                        child: SvgPicture.asset(
                          'assets/icons/ic_volume_high.svg',
                          width: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                isActive: _isTtsActive,
                onChanged: (val) {
                  setState(() {
                    _isTtsActive = val;
                  });
                },
              ),

              const Spacer(),

              // ── Primary Button ───────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Validasi minimal 1 harus menyala sesuai instruksi
                    if (!_isLabelWarnaActive && !_isTtsActive) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Minimal salah satu fitur harus diaktifkan.'),
                        ),
                      );
                      return;
                    }
                    
                    String option = '';
                    if (_isLabelWarnaActive && _isTtsActive) {
                      option = 'Keduanya';
                    } else if (_isLabelWarnaActive) {
                      option = 'Label Warna';
                    } else {
                      option = 'Text-to-Speech';
                    }
                    
                    ref.read(userPreferencesProvider.notifier).setAccessibilityOption(option);
                    ref.read(userPreferencesProvider.notifier).setFilterMode(false); // Default OFF
                    
                    // Navigate to 08 - Izin Kamera
                    context.push('/izin-kamera');
                  },
                  child: const Text('Selesai'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceCard({
    required String title,
    required String subtitle,
    String? iconPath,
    Widget? iconWidget,
    required bool isActive,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.surfaceSecondary,
        border: Border.all(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.4)
              : const Color(0xFF1E1E30),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          // Icon
          if (iconWidget != null)
            iconWidget
          else if (iconPath != null)
            SvgPicture.asset(
              iconPath,
              width: 24,
            ),

          const SizedBox(width: 10),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textStyles.labelSmall.copyWith(
                    color: context.colors.textSecondary,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
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

          const SizedBox(width: 10),

          // Switch
          Transform.scale(
            scale: 0.7, // Scale down to match Figma switch size
            child: CupertinoSwitch(
              value: isActive,
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: context.colors.borderDefault,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
