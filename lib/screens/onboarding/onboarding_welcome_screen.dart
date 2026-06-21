import 'package:flutter/material.dart';

import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/widgets/step_indicator.dart';
import 'package:colorsense/screens/onboarding/pilih_tipe_cb_screen.dart';

// -----------------------------------------------------------------------------
// 02 - Onboarding Welcome  |  Figma node: 4:22
// -----------------------------------------------------------------------------

class OnboardingWelcomeScreen extends StatefulWidget {
  const OnboardingWelcomeScreen({super.key});

  @override
  State<OnboardingWelcomeScreen> createState() =>
      _OnboardingWelcomeScreenState();
}

class _OnboardingWelcomeScreenState extends State<OnboardingWelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: StepIndicator(currentStep: 1),
              ),

              const SizedBox(height: 40),

              // ── Headline ─────────────────────────────────────────────
              Text(
                'Dunia warna menjadi lebih jelas!',
                style: context.textStyles.headlineLarge.copyWith(
                  height: 32 / 24,
                ),
              ),

              const SizedBox(height: 12),

              // ── Sub-headline ─────────────────────────────────────────
              Text(
                'ColorSense membantu untuk mengidentifikasi, memahami, dan beradaptasi dengan warna.',
                style: context.textStyles.bodyMedium.copyWith(
                  height: 18 / 12,
                ),
              ),

              const SizedBox(height: 32),

              // ── Feature Card ─────────────────────────────────────────
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: context.colors.surfaceSecondary, // #12121b
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/app_logo.png',
                      width: 62,
                      height: 62,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Identifikasi \u00B7 Filter \u00B7 Simulasi\nPalet Aman \u00B7 Contrast Checker',
                      textAlign: TextAlign.center,
                      style: context.textStyles.bodySmall.copyWith(
                        height: 17 / 11,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ── Input Name ───────────────────────────────────────────
              Text(
                'NAMA',
                style: context.textStyles.labelXSmall.copyWith(
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                style: context.textStyles.titleSmall.copyWith(
                  color: context.colors.textPrimary,
                ),
                decoration: const InputDecoration(
                  hintText: 'Nama kamu (opsional)',
                ),
              ),

              const SizedBox(height: 24),

              // ── Primary Button ───────────────────────────────────────
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PilihTipeCbScreen(),
                    ),
                  );
                },
                child: const Text('Mulai \u2192'), // Mulai ->
              ),
            ],
          ),
        ),
      ),
    );
  }
}
