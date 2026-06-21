import 'package:flutter/material.dart';
import 'package:colorsense/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/providers/saved_colors_provider.dart';
import 'package:colorsense/screens/detail_warna_screen.dart';

// -----------------------------------------------------------------------------
// 17 - Tersimpan | Figma node: 12:258
// -----------------------------------------------------------------------------

class TersimpanScreen extends ConsumerStatefulWidget {
  const TersimpanScreen({super.key});

  @override
  ConsumerState<TersimpanScreen> createState() => _TersimpanScreenState();
}

class _TersimpanScreenState extends ConsumerState<TersimpanScreen> {
  int _selectedFilterIndex = 1; // 0: Favorit, 1: Semua, 2: Minggu ini, 3: Bulan ini

  final List<String> _filters = [
    'Favorit',
    'Semua',
    'Minggu ini',
    'Bulan Ini',
  ];

  @override
  Widget build(BuildContext context) {
    final allSavedColors = ref.watch(savedColorsProvider);
    final savedColors = _selectedFilterIndex == 0
        ? allSavedColors.where((c) => c.isFavorite).toList()
        : allSavedColors;

    return Scaffold(
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
                      style: context.textStyles.headlineLarge.copyWith(
                        fontSize: 17,
                      ),
                    ),
                  ),

                  // ── Filter Chips ─────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_filters.length, (index) {
                          final isActive = index == _selectedFilterIndex;
                          
                          // Build chip
                          Widget chip = GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedFilterIndex = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: index == 0 ? 0 : 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.primary.withValues(alpha: 0.14)
                                    : Colors.white.withValues(alpha: 0.04),
                                border: Border.all(
                                  color: isActive
                                      ? AppColors.primary.withValues(alpha: 0.3)
                                      : Colors.white.withValues(alpha: 0.05),
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Text(
                                _filters[index],
                                style: context.textStyles.labelMedium.copyWith(
                                  color: isActive
                                      ? const Color(0xFF9D97FF)
                                      : const Color(0xFF606080),
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          );

                          // If it's the Favorit chip (index 0), append a divider
                          if (index == 0) {
                            return Row(
                              children: [
                                chip,
                                Container(
                                  width: 1,
                                  height: 12,
                                  color: context.colors.borderDefault,
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                ),
                              ],
                            );
                          }

                          return chip;
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // ── Saved Items List ─────────────────────────────────────
                  Expanded(
                    child: savedColors.isEmpty 
                      ? Center(
                          child: Text(
                            _selectedFilterIndex == 0 ? "Belum ada warna favorit" : "Belum ada warna tersimpan",
                            style: context.textStyles.bodyMedium.copyWith(color: context.colors.textMuted),
                          )
                        ) 
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
                          itemCount: savedColors.length,
                          itemBuilder: (context, index) {
                            final colorItem = savedColors[index];
                            final int parsedColorValue = int.tryParse(colorItem.hex.replaceAll('#', '0xFF')) ?? 0xFF000000;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: _buildSavedItem(
                                color: Color(parsedColorValue),
                                title: colorItem.name,
                                hexCode: colorItem.hex,
                                time: 'Baru',
                                isFavorited: colorItem.isFavorite,
                                onFavoriteToggle: () {
                                  ref.read(savedColorsProvider.notifier).toggleFavorite(colorItem.hex);
                                },
                              ),
                            );
                          },
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

  Widget _buildSavedItem({
    required Color color,
    required String title,
    required String hexCode,
    required String time,
    required bool isFavorited,
    required VoidCallback onFavoriteToggle,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailWarnaScreen(
              isFromSaved: true,
              colorName: title,
              hexColor: hexCode,
            ),
          ),
        );
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: context.colors.surfaceSecondary,
          border: Border.all(color: context.colors.borderDefault),
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
                    style: context.textStyles.headlineMedium.copyWith(
                      color: context.colors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    hexCode,
                    style: context.textStyles.bodySmall.copyWith(
                      color: context.colors.textMuted,
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
                      style: context.textStyles.bodySmall.copyWith(
                        color: context.colors.textMuted,
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onFavoriteToggle,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          isFavorited ? Icons.star : Icons.star_border,
                          color: const Color(0xFFFFC663),
                          size: 18,
                        ),
                      ),
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
