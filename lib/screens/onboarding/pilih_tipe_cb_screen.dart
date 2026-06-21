import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/widgets/step_indicator.dart';
import 'package:colorsense/widgets/option_card.dart';
import 'package:colorsense/providers/user_preferences_provider.dart';

// -----------------------------------------------------------------------------
// 03 - Pilih Tipe CB  |  Figma node: 4:39
// -----------------------------------------------------------------------------

class PilihTipeCbScreen extends ConsumerStatefulWidget {
  const PilihTipeCbScreen({super.key});

  @override
  ConsumerState<PilihTipeCbScreen> createState() => _PilihTipeCbScreenState();
}

class _PilihTipeCbScreenState extends ConsumerState<PilihTipeCbScreen> {
  // We store selected index.
  int _selectedIndex = -1; // Default to no selection

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
                style: context.textStyles.headlineLarge.copyWith(
                  height: 30 / 24,
                ),
              ),

              const SizedBox(height: 12),

              // ── Sub-headline ─────────────────────────────────────────
              Text(
                'Pilih kondisi kamu. App akan menyesuaikan filter, palet, dan tampilan secara otomatis.',
                style: context.textStyles.bodyMedium.copyWith(
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
                    if (_selectedIndex == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pilih salah satu kondisi terlebih dahulu.')),
                      );
                      return;
                    }

                    final selectedTitle = _options[_selectedIndex]['title']!;
                    ref.read(userPreferencesProvider.notifier).setCbType(selectedTitle);

                    if (_selectedIndex == 3) {
                      // 3 is "Belum tahu"
                      context.push('/tes-ishihara');
                    } else if (_selectedIndex == 0 || _selectedIndex == 1) {
                      // 0, 1: CB Types -> Keparahan
                      context.push('/keparahan');
                    } else {
                      // 2: Achromatopsia, 4: Normal -> Preferensi
                      context.push('/preferensi');
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
