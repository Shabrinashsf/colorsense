import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:colorsense/theme/app_theme.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.navbarBg,
        border: Border(
          top: BorderSide(
            color: colors.navbarBorder.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(context, index: 0, iconPath: 'assets/icons/ic_home2.svg', label: 'Home'),
          _buildNavItem(context, index: 1, iconPath: 'assets/icons/ic_bubble.svg', label: 'Palet'),
          _buildNavItem(context, index: 2, iconPath: 'assets/icons/ic_instagram.svg', label: 'Kamera'),
          _buildNavItem(context, index: 3, iconPath: 'assets/icons/ic_archive_minus.svg', label: 'Simpan'),
          _buildNavItem(context, index: 4, iconPath: 'assets/icons/ic_setting2.svg', label: 'Setting'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {
    required int index,
    required String iconPath,
    required String label,
  }) {
    final colors = context.colors;
    final isActive = currentIndex == index;
    final color = isActive ? AppColors.primary : colors.navInactive;

    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: context.textStyles.bodySmall.copyWith(
              fontSize: 10,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
