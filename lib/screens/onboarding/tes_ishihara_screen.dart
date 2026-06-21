import 'package:flutter/material.dart';

import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/widgets/ishihara_option_button.dart';
import 'package:colorsense/screens/onboarding/hasil_tes_screen.dart';

// -----------------------------------------------------------------------------
// 04 - Tes Ishihara  |  Figma node: 4:71
// -----------------------------------------------------------------------------

class IshiharaQuestion {
  final String imagePath;
  final List<String> options;

  IshiharaQuestion({
    required this.imagePath,
    required this.options,
  });
}

class TesIshiharaScreen extends StatefulWidget {
  const TesIshiharaScreen({super.key});

  @override
  State<TesIshiharaScreen> createState() => _TesIshiharaScreenState();
}

class _TesIshiharaScreenState extends State<TesIshiharaScreen> {
  int _currentIndex = 0;
  String? _selectedOption;

  // Hardcoded 8 questions
  final List<IshiharaQuestion> _questions = [
    IshiharaQuestion(
      imagePath: 'assets/images/ishihara_1.png',
      options: ['12', '21', '74', 'Tidak terlihat'],
    ),
    IshiharaQuestion(
      imagePath: 'assets/images/ishihara_2.png',
      options: ['8', '3', '5', 'Tidak terlihat'],
    ),
    IshiharaQuestion(
      imagePath: 'assets/images/ishihara_3.png',
      options: ['29', '70', '74', 'Tidak terlihat'],
    ),
    IshiharaQuestion(
      imagePath: 'assets/images/ishihara_4.png',
      options: ['5', '2', 'Tidak terlihat', '15'],
    ),
    IshiharaQuestion(
      imagePath: 'assets/images/ishihara_5.png',
      options: ['3', '8', 'Tidak terlihat', '5'],
    ),
    IshiharaQuestion(
      imagePath: 'assets/images/ishihara_6.png',
      options: ['15', '17', 'Tidak terlihat', '13'],
    ),
    IshiharaQuestion(
      imagePath: 'assets/images/ishihara_7.png',
      options: ['74', '21', '47', 'Tidak terlihat'],
    ),
    IshiharaQuestion(
      imagePath: 'assets/images/ishihara_8.png',
      options: ['6', '8', '9', 'Tidak terlihat'],
    ),
  ];

  void _onNext() {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih salah satu jawaban dulu')),
      );
      return;
    }

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null; // reset selection
      });
    } else {
      // Temporary logic: determine result based on the last selected option (question 8)
      // Options for Q8: ['6', '8', '9', 'Tidak terlihat']
      String dummyResult = 'Deuteranopia/Protanopia';
      if (_selectedOption == '6') {
        dummyResult = 'Tritanopia';
      } else if (_selectedOption == '8') {
        dummyResult = 'Deuteranopia/Protanopia';
      } else if (_selectedOption == '9') {
        dummyResult = 'Achromatopsia';
      } else if (_selectedOption == 'Tidak terlihat') {
        dummyResult = 'Tidak buta warna';
      }

      // Finished 8 questions -> Navigate to 05 - Hasil Tes
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HasilTesScreen(tipe: dummyResult),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentIndex];
    final progressNumber = _currentIndex + 1;
    final progressFraction = progressNumber / _questions.length;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenH, // 20
            vertical: AppSpacing.screenV,   // 40
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // ── Top Badge ────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  'TES ISHIHARA \u2014 SOAL $progressNumber DARI ${_questions.length}',
                  style: context.textStyles.labelXSmall.copyWith(
                    color: context.colors.textLabel,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ── Headline ─────────────────────────────────────────────
              Text(
                'Angka berapa yang\nkamu lihat?',
                textAlign: TextAlign.center,
                style: context.textStyles.headlineLarge.copyWith(
                  height: 28 / 24,
                ),
              ),

              const SizedBox(height: 12),

              // ── Sub-headline ─────────────────────────────────────────
              Text(
                'Lihat gambar dengan seksama. Lalu pilih jawaban yang sesuai.',
                textAlign: TextAlign.center,
                style: context.textStyles.bodyMedium.copyWith(
                  fontSize: 11,
                  height: 17 / 11,
                ),
              ),

              const SizedBox(height: 32),

              // ── Ishihara Image ───────────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(38),
                child: Image.asset(
                  currentQuestion.imagePath,
                  width: 202,
                  height: 202,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 32),

              // ── Progress Bar ─────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: context.colors.textMuted,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: progressFraction,
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$progressNumber/${_questions.length}',
                    style: context.textStyles.labelXSmall.copyWith(
                      color: const Color(0xFF606080),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // ── Options Grid ─────────────────────────────────────────
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: IshiharaOptionButton(
                          text: currentQuestion.options[0],
                          isSelected: _selectedOption == currentQuestion.options[0],
                          onTap: () => setState(() => _selectedOption = currentQuestion.options[0]),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: IshiharaOptionButton(
                          text: currentQuestion.options[1],
                          isSelected: _selectedOption == currentQuestion.options[1],
                          onTap: () => setState(() => _selectedOption = currentQuestion.options[1]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: IshiharaOptionButton(
                          text: currentQuestion.options[2],
                          isSelected: _selectedOption == currentQuestion.options[2],
                          onTap: () => setState(() => _selectedOption = currentQuestion.options[2]),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: IshiharaOptionButton(
                          text: currentQuestion.options[3],
                          isSelected: _selectedOption == currentQuestion.options[3],
                          onTap: () => setState(() => _selectedOption = currentQuestion.options[3]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Primary Button ───────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onNext,
                  child: const Text('Lanjut \u2192'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
