import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/providers/user_preferences_provider.dart';

// -----------------------------------------------------------------------------
// 13 - Filter Mode | Figma node: 12:43
// -----------------------------------------------------------------------------

class FilterModeScreen extends ConsumerStatefulWidget {
  const FilterModeScreen({super.key});

  @override
  ConsumerState<FilterModeScreen> createState() => _FilterModeScreenState();
}

class _FilterModeScreenState extends ConsumerState<FilterModeScreen> {
  int _selectedTabIndex = 0;
  int _selectedFilterIndex = -1; // -1 means no filter selected initially

  final List<String> _tabs = [
    'Default',
    'Deuteranopia',
    'Tritanopia',
    'Achromatopsia',
    'Protanopia',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userPrefs = ref.read(userPreferencesProvider);
      if (userPrefs.filterMode && userPrefs.filterModeName.isNotEmpty) {
        setState(() {
          if (userPrefs.filterModeName == 'High Contrast') _selectedFilterIndex = 0;
          else if (userPrefs.filterModeName == 'Soft Gray') _selectedFilterIndex = 1;
          else if (userPrefs.filterModeName == 'Cool Contrast') _selectedFilterIndex = 2;
          else if (userPrefs.filterModeName == 'Warm Contrast') _selectedFilterIndex = 3;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              colorFilter: ColorFilter.mode(
                                context.colors.textPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Mode Filter',
                          style: context.textStyles.headlineMedium.copyWith(
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
                                horizontal: 14,
                                vertical: 6,
                              ),
                              alignment: Alignment.center,
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
                                style: context.textStyles.labelMedium.copyWith(
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
                    const SizedBox(height: 10),                    // ── Filter Grid ────────────────────────────────────────
                    Expanded(
                      child: GridView(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 80,
                        ),
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
                      onTap: () {},
                      child: Container(
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF12121E),
                          border: Border.all(color: const Color(0xFF1E1E30)),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          'Preview',
                          style: context.textStyles.labelMedium.copyWith(
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
                        if (_selectedFilterIndex != -1) {
                          String filterName = '';
                          if (_selectedFilterIndex == 0) filterName = 'High Contrast';
                          else if (_selectedFilterIndex == 1) filterName = 'Soft Gray';
                          else if (_selectedFilterIndex == 2) filterName = 'Cool Contrast';
                          else if (_selectedFilterIndex == 3) filterName = 'Warm Contrast';

                          ref.read(userPreferencesProvider.notifier).setFilterMode(true, name: filterName);
                        } else {
                          // If they deselect everything (which isn't possible yet) or if we add a "Matikan" option
                          ref.read(userPreferencesProvider.notifier).setFilterMode(false);
                        }
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          'Terapkan',
                          style: context.textStyles.labelMedium.copyWith(
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
          color: context.colors.surfaceSecondary,
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFF1E1E30),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Color Rectangles Row
            Row(
              children: [
                _buildSwatch(colors[0]),
                const SizedBox(width: 3),
                _buildSwatch(colors[1]),
                const SizedBox(width: 3),
                _buildSwatch(colors[2]),
                const SizedBox(width: 3),
                _buildSwatch(colors[3]),
              ],
            ),
            const SizedBox(height: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textStyles.headlineMedium.copyWith(
                    color: const Color(0xFFC0C0E0),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: context.textStyles.bodySmall.copyWith(
                    color: const Color(0xFFAFADDF),
                    fontSize: 8,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwatch(Color color) {
    return Container(
      width: 27,
      height: 18,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
