import 'package:flutter/material.dart';

import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/widgets/step_indicator.dart';
import 'package:colorsense/widgets/option_card.dart';
import 'package:colorsense/screens/onboarding/tes_ishihara_screen.dart';
import 'package:colorsense/screens/onboarding/keparahan_screen.dart';
import 'package:colorsense/screens/onboarding/preferensi_screen.dart';

// -----------------------------------------------------------------------------
// 03 - Pilih Tipe CB  |  Figma node: 4:39
// -----------------------------------------------------------------------------

class PilihTipeCbScreen extends StatefulWidget {
  const PilihTipeCbScreen({super.key});

  @override
  State<PilihTipeCbScreen> createState() => _PilihTipeCbScreenState();
}

class _PilihTipeCbScreenState extends State<PilihTipeCbScreen> {
  // We store selected index.
  int _selectedIndex = 3; // Default 'Belum tahu' is selected in design

  final List<Map<String, String>> _options = [
    {
      'icon': 'assets/icons/cb_tritanopia.svg',
      'title': 'Tritanopia',
      'subtitle': 'Sulit membedakan Biru & Kuning',
    },
    {
      'icon': 'assets/icons/cb_deutan.svg',
      'title': 'Deuteranopia / Protanopia',
      'subtitle': 'Sulit membedakan Merah & Hijau',
    },
    {
      'icon': 'assets/icons/cb_achroma.svg',
      'title': 'Achromatopsia',
      'subtitle': 'Tidak bisa melihat warna sama sekali',
    },
    {
      'icon': 'assets/icons/ic_search.svg',
      'title': 'Belum tahu',
      'subtitle': 'Kami bantu identifikasi melalui tes singkat',
    },
    {
      'icon': 'assets/icons/ic_close_square.svg',
      'title': 'Saya tidak buta warna',
      'subtitle': 'Pakai app untuk desain / bantu orang lain',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
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
                child: StepIndicator(currentStep: 2),
              ),

              const SizedBox(height: 40),

              // ── Headline ─────────────────────────────────────────────
              Text(
                'Warna apa yang\nsulit dibedakan?',
                style: AppTextStyles.headlineLarge.copyWith(
                  height: 30 / 24,
                ),
              ),

              const SizedBox(height: 12),

              // ── Sub-headline ─────────────────────────────────────────
              Text(
                'Pilih kondisi kamu. App akan menyesuaikan filter, palet, dan tampilan secara otomatis.',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 11,
                  height: 17 / 11,
                ),
              ),

              const SizedBox(height: 32),

              // ── Options List ─────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  itemCount: _options.length,
                  itemBuilder: (context, index) {
                    final option = _options[index];
                    return OptionCard(
                      iconPath: option['icon']!,
                      title: option['title']!,
                      subtitle: option['subtitle']!,
                      isSelected: _selectedIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // ── Primary Button ───────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedIndex == 3) {
                      // 3 is "Belum tahu"
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const TesIshiharaScreen(),
                        ),
                      );
                    } else if (_selectedIndex == 0 || _selectedIndex == 1) {
                      // 0: Tritanopia, 1: Deuteranopia/Protanopia -> Keparahan
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const KeparahanScreen(),
                        ),
                      );
                    } else {
                      // 2: Achromatopsia, 4: Normal -> Preferensi
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PreferensiScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Lanjut \u2192'), // Lanjut ->
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
