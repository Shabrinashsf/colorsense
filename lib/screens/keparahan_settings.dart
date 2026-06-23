import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/providers/user_preferences_provider.dart';
import 'package:colorsense/screens/onboarding/tes_ishihara_screen.dart';

// -----------------------------------------------------------------------------
// 22 - Keparahan Settings | Figma node: 13:122
// -----------------------------------------------------------------------------

class KeparahanSettingsScreen extends ConsumerStatefulWidget {
  const KeparahanSettingsScreen({super.key});

  @override
  ConsumerState<KeparahanSettingsScreen> createState() => _KeparahanSettingsScreenState();
}

class _KeparahanSettingsScreenState extends ConsumerState<KeparahanSettingsScreen> {
  int _selectedSeverityIndex = 1; // 0: Ringan, 1: Sedang, 2: Berat

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userPrefs = ref.read(userPreferencesProvider);
      setState(() {
        if (userPrefs.severity == 'Ringan') {
          _selectedSeverityIndex = 0;
        } else if (userPrefs.severity == 'Berat') _selectedSeverityIndex = 2;
        else _selectedSeverityIndex = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = ref.watch(userPreferencesProvider);
    final String cbTypeStr = userPrefs.cbType.isEmpty ? 'Belum Diatur' : userPrefs.cbType;
    final bool isTritanopia = cbTypeStr == 'Tritanopia';
    String descStr = 'Sulit membedakan warna';
    if (cbTypeStr == 'Tritanopia') descStr = 'Sulit membedakan Biru & Kuning';
    if (cbTypeStr == 'Deuteranopia/Protanopia') descStr = 'Sulit membedakan Merah & Hijau';
    if (cbTypeStr == 'Achromatopsia') descStr = 'Tidak bisa melihat warna sama sekali';
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tipe Buta Warna',
                                style: context.textStyles.headlineMedium.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                'Pilih tipe buta warna sesuai dengan kondisimu.',
                                style: context.textStyles.bodySmall.copyWith(
                                  color: context.colors.textMuted,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Kondisi Sekarang ───────────────────────────────────
                    _buildSectionTitle('KONDISI SEKARANG'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceSecondary,
                        border: Border.all(color: context.colors.borderDefault, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: isTritanopia 
                                  ? const [Color(0xFF3498DB), Color(0xFFF1C40F)] 
                                  : cbTypeStr == 'Achromatopsia' 
                                    ? const [Colors.white, Color(0xFF4A4A4A)]
                                    : const [Color(0xFFD55E00), Color(0xFF009E73)],
                                stops: const [0.5, 0.5],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cbTypeStr,
                                  style: context.textStyles.headlineMedium.copyWith(
                                    color: context.colors.textSecondary,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  descStr,
                                  style: context.textStyles.bodySmall.copyWith(
                                    color: context.colors.textMuted,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TesIshiharaScreen(isRetake: true),
                                ),
                              );
                            },
                            child: Text(
                              'Tes Ulang',
                              style: context.textStyles.labelMedium.copyWith(
                                color: const Color(0xFF6C63FF),
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Warna Asli ─────────────────────────────────────────
                    _buildSectionTitle('WARNA ASLI'),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: isTritanopia ? const Color(0xFF3498DB) : const Color(0xFFC0392B), // Biru atau Merah
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isTritanopia ? 'BIRU' : 'MERAH',
                                style: context.textStyles.headlineMedium.copyWith(
                                  color: context.colors.textMuted,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: isTritanopia ? const Color(0xFFF1C40F) : const Color(0xFF27AE60), // Kuning atau Hijau
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isTritanopia ? 'KUNING' : 'HIJAU',
                                style: context.textStyles.headlineMedium.copyWith(
                                  color: context.colors.textMuted,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Preview ────────────────────────────────────────────
                    _buildSectionTitle('PREVIEW'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildSeverityColumn(
                            index: 0,
                            title: 'RINGAN',
                            titleColor: const Color(0xFF00D9A3),
                            color1: isTritanopia ? const Color(0xFF5D8AA8) : const Color(0xFFB04020),
                            color2: isTritanopia ? const Color(0xFFE6C229) : const Color(0xFF708040),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildSeverityColumn(
                            index: 1,
                            title: 'SEDANG',
                            titleColor: const Color(0xFFFFC663),
                            color1: isTritanopia ? const Color(0xFF719B8F) : const Color(0xFF987040),
                            color2: isTritanopia ? const Color(0xFFDDA0DD) : const Color(0xFF907848),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildSeverityColumn(
                            index: 2,
                            title: 'BERAT',
                            titleColor: const Color(0xFFFF6B6B),
                            color1: isTritanopia ? const Color(0xFF40E0D0) : const Color(0xFF8A7A40),
                            color2: isTritanopia ? const Color(0xFFFFC0CB) : const Color(0xFF8A7A40),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Simpan Button ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.screenH, 10, AppSpacing.screenH, 20),
              child: GestureDetector(
                onTap: () {
                  String severityStr = 'Sedang';
                  if (_selectedSeverityIndex == 0) severityStr = 'Ringan';
                  if (_selectedSeverityIndex == 2) severityStr = 'Berat';
                  
                  ref.read(userPreferencesProvider.notifier).setSeverity(severityStr);
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Simpan Perubahan',
                    style: context.textStyles.labelLarge.copyWith(
                      color: context.colors.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: context.textStyles.labelMedium.copyWith(
          color: context.colors.textLabel,
          fontSize: 8,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildSeverityColumn({
    required int index,
    required String title,
    required Color titleColor,
    required Color color1,
    required Color color2,
  }) {
    final isSelected = _selectedSeverityIndex == index;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textStyles.headlineMedium.copyWith(
                  color: titleColor,
                  fontSize: 8,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedSeverityIndex = index;
            });
          },
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.primary : Colors.transparent,
              border: Border.all(
                color: isSelected ? AppColors.primary : const Color(0xFF1E1E30),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
