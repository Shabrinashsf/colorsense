import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class IshiharaOptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const IshiharaOptionButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFF1E1E30),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: context.textStyles.titleSmall.copyWith(
            fontSize: text.length > 2 ? 13 : 15,
            color: isSelected ? const Color(0xFF9D97FF) : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
