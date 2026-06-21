import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/screens/color_identifier_screen.dart';
import 'package:colorsense/utils/wcag_checker.dart';

// -----------------------------------------------------------------------------
// 14 - Contrast Checker | Figma node: 12:104
// -----------------------------------------------------------------------------

enum InputMode { type, cam, pick }

class ContrastCheckerScreen extends StatefulWidget {
  const ContrastCheckerScreen({super.key});

  @override
  State<ContrastCheckerScreen> createState() => _ContrastCheckerScreenState();
}

class _ContrastCheckerScreenState extends State<ContrastCheckerScreen> {
  InputMode _leftMode = InputMode.type;
  InputMode _rightMode = InputMode.type;

  Color _leftColor = const Color(0xFFF0F0FF);
  Color _rightColor = const Color(0xFF2980B9);

  bool _showResult = false;
  double _contrastRatio = 1.0;

  void _calculateContrast() {
    setState(() {
      _contrastRatio = WcagChecker.getContrastRatio(_leftColor, _rightColor);
      _showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    'Contrast Checker',
                    style: context.textStyles.headlineMedium.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Previews ───────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 126,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _rightColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Aa',
                        style: context.textStyles.headlineLarge.copyWith(
                          color: _leftColor,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 126,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _leftColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Aa',
                        style: context.textStyles.headlineLarge.copyWith(
                          color: _rightColor,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ── Input Controls ─────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _buildInputControl(
                      color: _leftColor,
                      hexText: '#${_leftColor.value.toRadixString(16).substring(2).toUpperCase()}',
                      currentMode: _leftMode,
                      onModeChanged: (mode) {
                        setState(() {
                          _leftMode = mode;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputControl(
                      color: _rightColor,
                      hexText: '#${_rightColor.value.toRadixString(16).substring(2).toUpperCase()}',
                      currentMode: _rightMode,
                      onModeChanged: (mode) {
                        setState(() {
                          _rightMode = mode;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Check Button ───────────────────────────────────────
              GestureDetector(
                onTap: _calculateContrast,
                child: Container(
                  width: double.infinity,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text(
                    'Cek Kontras',
                    style: context.textStyles.labelMedium.copyWith(
                      color: context.colors.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // ── Hasil Pengecekan ───────────────────────────────────
              if (_showResult) ...[
                Text(
                  'HASIL PENGECEKAN KONTRAS',
                  style: context.textStyles.labelXSmall.copyWith(
                    color: context.colors.textLabel,
                    fontSize: 8,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceSecondary,
                    border: Border.all(color: context.colors.borderDefault),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Column(
                    children: [
                      // Rasio
                      Text(
                        '${_contrastRatio.toStringAsFixed(1)}:1',
                        style: context.textStyles.headlineLarge.copyWith(
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        'Rasio Kontras',
                        style: context.textStyles.bodySmall.copyWith(
                          fontSize: 9,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // WCAG Rules
                      _buildWcagRow('WCAG AA Normal (4.5:1)', _contrastRatio >= 4.5),
                      const SizedBox(height: 8),
                      _buildWcagRow('WCAG AA Besar (3:1)', _contrastRatio >= 3.0),
                      const SizedBox(height: 8),
                      _buildWcagRow('WCAG AAA Normal (7:1)', _contrastRatio >= 7.0),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputControl({
    required Color color,
    required String hexText,
    required InputMode currentMode,
    required ValueChanged<InputMode> onModeChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colors.surfaceSecondary,
        border: Border.all(color: context.colors.borderDefault),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        children: [
          // Color Preview and Input Action
          Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDynamicInputAction(context, currentMode, hexText),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTab(
                label: 'Type',
                isActive: currentMode == InputMode.type,
                activeColor: const Color(0xFF6C63FF),
                onTap: () => onModeChanged(InputMode.type),
              ),
              _buildTab(
                label: 'Cam',
                isActive: currentMode == InputMode.cam,
                activeColor: const Color(0xFF00D9A3),
                onTap: () => onModeChanged(InputMode.cam),
              ),
              _buildTab(
                label: 'Pick',
                isActive: currentMode == InputMode.pick,
                activeColor: const Color(0xFFFFC663),
                onTap: () => onModeChanged(InputMode.pick),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicInputAction(BuildContext context, InputMode mode, String hexText) {
    if (mode == InputMode.type) {
      return SizedBox(
        height: 20,
        child: TextField(
          controller: TextEditingController(text: hexText),
          style: context.textStyles.bodySmall.copyWith(
            color: context.colors.textMuted,
            fontSize: 9,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: 12),
            isDense: true,
          ),
        ),
      );
    } else if (mode == InputMode.cam) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ColorIdentifierScreen(),
            ),
          );
        },
        child: Text(
          'Buka Kamera',
          style: context.textStyles.labelSmall.copyWith(
            color: const Color(0xFF00D9A3),
            fontSize: 9,
            decoration: TextDecoration.underline,
            decorationColor: const Color(0xFF00D9A3),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: context.colors.surfaceSecondary,
              title: Text('Color Picker', style: context.textStyles.headlineMedium),
              content: Text(
                'Pop-up Color Picker akan muncul di sini.',
                style: context.textStyles.bodySmall.copyWith(color: context.colors.textPrimary),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Tutup', style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
          );
        },
        child: Text(
          'Pilih Warna',
          style: context.textStyles.labelSmall.copyWith(
            color: const Color(0xFFFFC663),
            fontSize: 9,
            decoration: TextDecoration.underline,
            decorationColor: const Color(0xFFFFC663),
          ),
        ),
      );
    }
  }

  Widget _buildTab({
    required String label,
    required bool isActive,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          style: context.textStyles.bodySmall.copyWith(
            color: isActive ? activeColor : const Color(0xFF606080),
            fontSize: 8,
          ),
        ),
      ),
    );
  }

  Widget _buildWcagRow(String label, bool isPass) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textStyles.bodySmall.copyWith(
            color: context.colors.textMuted,
            fontSize: 9,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: isPass
                ? const Color(0xFF00D9A3).withValues(alpha: 0.1)
                : const Color(0xFFFF8080).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            isPass ? 'KONTRAS' : 'KONTRAS RENDAH',
            style: context.textStyles.labelSmall.copyWith(
              color: isPass ? const Color(0xFF00D9A3) : const Color(0xFFFF8080),
              fontSize: 8,
            ),
          ),
        ),
      ],
    );
  }
}
