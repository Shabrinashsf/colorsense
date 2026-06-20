import 'package:flutter/material.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/widgets/bottom_navbar.dart';
import 'package:colorsense/screens/home_dashboard_on.dart';
import 'package:colorsense/screens/color_identifier_screen.dart';
import 'package:colorsense/screens/detail_palet.dart';

// -----------------------------------------------------------------------------
// 15 - Palet Warna | Figma node: 12:150
// -----------------------------------------------------------------------------

class PaletWarnaScreen extends StatefulWidget {
  const PaletWarnaScreen({super.key});

  @override
  State<PaletWarnaScreen> createState() => _PaletWarnaScreenState();
}

class _PaletWarnaScreenState extends State<PaletWarnaScreen> {
  int _selectedFilterIndex = 1; // "CB-Safe" is active in Figma

  final List<String> _filters = [
    'Semua',
    'CB-Safe',
    'Deuteranopia',
    'Tritanopia',
    'Achromatopsia',
    'Protanopia'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header & Search ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenH,
                AppSpacing.screenV,
                AppSpacing.screenH,
                10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Palet Warna',
                    style: AppTextStyles.headlineLarge.copyWith(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Search Bar
                  Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSecondary,
                      border: Border.all(color: const Color(0xFF1E1E30)),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0xFFAFADDF),
                          size: 14,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Cari warna atau palet...',
                              hintStyle: AppTextStyles.bodySmall.copyWith(
                                color: const Color(0xFFAFADDF),
                                fontSize: 10,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable Filter Chips ──────────────────────────────
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
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
            const SizedBox(height: 15),

            // ── Palette List ──────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
                children: [
                  _buildPaletteCard(
                    title: 'Okabe-Ito',
                    subtitle: 'Paling direkomendasikan',
                    colors: [
                      const Color(0xFFE69F00),
                      const Color(0xFF56B4E9),
                      const Color(0xFF009E73),
                      const Color(0xFFF0E442),
                      const Color(0xFF0072B2),
                      const Color(0xFFD55E00),
                    ],
                    onTapDetail: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailPaletScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildPaletteCard(
                    title: "Wong's Palette",
                    subtitle: 'Kontras tinggi',
                    colors: [
                      const Color(0xFF0077BB),
                      const Color(0xFF33BBEE),
                      const Color(0xFF009988),
                      const Color(0xFFEE7733),
                      const Color(0xFFCC3311),
                      const Color(0xFFEE3377),
                    ],
                    onTapDetail: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailPaletScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildPaletteCard(
                    title: "Tol's Bright",
                    subtitle: 'Scientific viz',
                    colors: [
                      const Color(0xFF332288),
                      const Color(0xFF117733),
                      const Color(0xFF44AA99),
                      const Color(0xFF88CCEE),
                      const Color(0xFFDDCC77),
                      const Color(0xFFCC6677),
                    ],
                    onTapDetail: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailPaletScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // ── Bottom Navbar ────────────────────────────────────────
            BottomNavbar(
              currentIndex: 1, // Palet is index 1
              onTap: (index) {
                if (index == 0) {
                  // Back to Home
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeDashboardOnScreen(),
                    ),
                    (route) => false,
                  );
                } else if (index == 2) {
                  // To Kamera
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ColorIdentifierScreen(),
                    ),
                  );
                }
                // (Simpan and Setting to be added later)
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaletteCard({
    required String title,
    required String subtitle,
    required List<Color> colors,
    required VoidCallback onTapDetail,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        border: Border.all(color: const Color(0xFF1E1E30)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Color Stripes
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Row(
              children: colors.map((color) {
                return Expanded(
                  child: Container(
                    height: 34,
                    color: color,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          
          // Details and Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: const Color(0xFFD0D0F0),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: const Color(0xFFAFADDF),
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTapDetail,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00D9A3).withValues(alpha: 0.08),
                    border: Border.all(
                      color: const Color(0xFF00D9A3).withValues(alpha: 0.15),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Liat Detail',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: const Color(0xFF00D9A3),
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
