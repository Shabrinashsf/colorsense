import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// 13 - Filter Mode | Figma node: 12:43
// -----------------------------------------------------------------------------

class FilterModeScreen extends StatefulWidget {
  const FilterModeScreen({super.key});

  @override
  State<FilterModeScreen> createState() => _FilterModeScreenState();
}

class _FilterModeScreenState extends State<FilterModeScreen> {
  int _selectedTabIndex = 0;
  int _selectedFilterIndex = 2; // "Cool Contrast" as default in Figma

  final List<String> _tabs = [
    'Default',
    'Deuteranopia',
    'Tritanopia',
    'Achromatopsia',
    'Protanopia',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
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
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Mode Filter',
                          style: AppTextStyles.headlineMedium.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Scrollable Tabs ────────────────────────────────────
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_tabs.length, (index) {
                          final isSelected = index == _selectedTabIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTabIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 7),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary.withValues(alpha: 0.14)
                                    : Colors.white.withValues(alpha: 0.04),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary.withValues(alpha: 0.3)
                                      : Colors.white.withValues(alpha: 0.05),
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Text(
                                _tabs[index],
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: isSelected
                                      ? const Color(0xFF9D97FF)
                                      : const Color(0xFF606080),
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Filter Grid ────────────────────────────────────────
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.15,
                        children: [
                          _buildFilterCard(
                            index: 0,
                            title: 'High Contrast',
                            subtitle: 'Hitam-putih',
                            colors: [
                              const Color(0xFF111111),
                              const Color(0xFF555555),
                              const Color(0xFFBBBBBB),
                              const Color(0xFFEEEEEE),
                            ],
                          ),
                          _buildFilterCard(
                            index: 1,
                            title: 'Soft Gray',
                            subtitle: 'Grayscale lembut',
                            colors: [
                              const Color(0xFF333333),
                              const Color(0xFF777777),
                              const Color(0xFFAAAAAA),
                              const Color(0xFFCCCCCC),
                            ],
                          ),
                          _buildFilterCard(
                            index: 2,
                            title: 'Cool Contrast',
                            subtitle: 'Aktifitas Siang Hari',
                            colors: [
                              const Color(0xFF1A1A2E),
                              const Color(0xFF6C63FF),
                              const Color(0xFFFFFFFF),
                              const Color(0xFFEEEEEE),
                            ],
                          ),
                          _buildFilterCard(
                            index: 3,
                            title: 'Warm Contrast',
                            subtitle: 'Aktifitas Malam Hari',
                            colors: [
                              const Color(0xFFFFF8E0),
                              const Color(0xFF3D2000),
                              const Color(0xFFFF9900),
                              const Color(0xFF000000),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom Buttons ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.screenH,
                right: AppSpacing.screenH,
                bottom: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 80,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Handle preview
                      },
                      child: Container(
                        height: 48, // Taller than Figma's 38px for touch target
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceSecondary,
                          border: Border.all(color: const Color(0xFF1E1E30)),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          'Preview',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: const Color(0xFFD0D0F0),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 194,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Handle terapkan
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          'Terapkan',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: const Color(0xFFF0F0FF),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterCard({
    required int index,
    required String title,
    required String subtitle,
    required List<Color> colors,
  }) {
    final isSelected = _selectedFilterIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilterIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.06)
              : AppColors.surfaceSecondary,
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFF1E1E30),
            width: isSelected ? 1.5 : 1.0,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color Rectangles Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: colors.map((color) {
                return Container(
                  width: 27,
                  height: 18,
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            Text(
              title,
              style: AppTextStyles.labelMedium.copyWith(
                color: const Color(0xFFC0C0E0),
                fontSize: 9,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: const Color(0xFFAFADDF),
                fontSize: 8,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
