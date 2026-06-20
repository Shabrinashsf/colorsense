import 'package:flutter/material.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/widgets/bottom_navbar.dart';
import 'package:colorsense/screens/home_dashboard_on.dart';
import 'package:colorsense/screens/palet_warna.dart';
import 'package:colorsense/screens/color_identifier_screen.dart';
import 'package:colorsense/screens/detail_warna_screen.dart';

// -----------------------------------------------------------------------------
// 17 - Tersimpan | Figma node: 12:258
// -----------------------------------------------------------------------------

class TersimpanScreen extends StatefulWidget {
  const TersimpanScreen({super.key});

  @override
  State<TersimpanScreen> createState() => _TersimpanScreenState();
}

class _TersimpanScreenState extends State<TersimpanScreen> {
  int _selectedFilterIndex = 0; // 0: Semua, 1: Minggu ini, 2: Bulan ini
  bool _isFavoritActive = false;

  final List<String> _filters = [
    'Semua',
    'Minggu ini',
    'Bulan Ini',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header ───────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenH,
                      AppSpacing.screenV,
                      AppSpacing.screenH,
                      10,
                    ),
                    child: Text(
                      'Tersimpan',
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontSize: 17,
                      ),
                    ),
                  ),

                  // ── Filter Chips ─────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
                    child: Row(
                      children: [
                        // Favorit Toggle
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFavoritActive = !_isFavoritActive;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _isFavoritActive
                                  ? AppColors.primary.withValues(alpha: 0.15)
                                  : AppColors.surfaceSecondary,
                              border: Border.all(
                                color: _isFavoritActive
                                    ? AppColors.primary.withValues(alpha: 0.3)
                                    : const Color(0xFF1E1E30),
                              ),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Text(
                              'Favorit',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: _isFavoritActive
                                    ? const Color(0xFF9D97FF)
                                    : const Color(0xFFAFADDF),
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),
                        
                        // Divider
                        Container(
                          width: 1,
                          height: 22,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          color: const Color(0xFF1E1E30),
                        ),

                        // Time Filters
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(_filters.length, (index) {
                                final isSelected = index == _selectedFilterIndex;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedFilterIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary.withValues(alpha: 0.15)
                                          : AppColors.surfaceSecondary,
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primary.withValues(alpha: 0.3)
                                            : const Color(0xFF1E1E30),
                                      ),
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                    child: Text(
                                      _filters[index],
                                      style: AppTextStyles.labelMedium.copyWith(
                                        color: isSelected
                                            ? const Color(0xFF9D97FF)
                                            : const Color(0xFFAFADDF),
                                        fontSize: 9,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // ── Saved Items List ─────────────────────────────────────
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
                      children: [
                        _buildSavedItem(
                          color: const Color(0xFF0047AB),
                          title: 'Biru Cobalt',
                          hexCode: '#0047AB',
                          time: '2m',
                          isFavorited: true,
                        ),
                        const SizedBox(height: 5),
                        _buildSavedItem(
                          color: const Color(0xFF50C878),
                          title: 'Hijau Emerald',
                          hexCode: '#50C878',
                          time: '1j',
                          isFavorited: false,
                        ),
                        const SizedBox(height: 5),
                        _buildSavedItem(
                          color: const Color(0xFFE67E22),
                          title: 'Oranye Carrot',
                          hexCode: '#E67E22',
                          time: '3j',
                          isFavorited: false,
                        ),
                        const SizedBox(height: 5),
                        _buildSavedItem(
                          color: const Color(0xFF9966CC),
                          title: 'Ungu Amethyst',
                          hexCode: '#9966CC',
                          time: 'Kmrn',
                          isFavorited: true,
                        ),
                        const SizedBox(height: 5),
                        _buildSavedItem(
                          color: const Color(0xFFE32636),
                          title: 'Merah Alizarin',
                          hexCode: '#E32636',
                          time: '2hr',
                          isFavorited: false,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Bottom Navbar ──────────────────────────────────────────────
            BottomNavbar(
              currentIndex: 3, // Simpan is index 3
              onTap: (index) {
                if (index == 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeDashboardOnScreen(),
                    ),
                    (route) => false,
                  );
                } else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaletWarnaScreen(),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ColorIdentifierScreen(),
                    ),
                  );
                }
                // (index == 4 for Setting will be added later)
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedItem({
    required Color color,
    required String title,
    required String hexCode,
    required String time,
    required bool isFavorited,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailWarnaScreen(isFromSaved: true),
          ),
        );
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.surfaceSecondary,
          border: Border.all(color: const Color(0xFF1E1E30)),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: const Color(0xFFD0D0F0),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    hexCode,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: const Color(0xFFAFADDF),
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      time,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: const Color(0xFFAFADDF),
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isFavorited ? Icons.star : Icons.star_border,
                      color: const Color(0xFFFFC663),
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
