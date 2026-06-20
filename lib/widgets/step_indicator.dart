import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 22,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background line connecting steps
          Positioned(
            left: 59, // middle of step 1 (width 118 / 2)
            right: 11, // middle of step 4 (width 23 / 2)
            child: Container(
              height: 1.5,
              color: AppColors.primaryDark,
            ),
          ),
          // Steps
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (i) {
              final stepIndex = i + 1;
              final isActive = stepIndex <= currentStep;
              
              if (stepIndex == 1) {
                return _buildStep1(isActive);
              }
              return _buildSmallStep(stepIndex, isActive);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1(bool isActive) {
    return Container(
      height: 22,
      width: 118,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.primaryDark,
        borderRadius: BorderRadius.circular(11),
      ),
      alignment: Alignment.center,
      child: Text(
        '1 \u2014 SELAMAT DATANG',
        style: AppTextStyles.labelXSmall.copyWith(
          color: isActive ? AppColors.textOnPrimary : AppColors.textLabel,
        ),
      ),
    );
  }

  Widget _buildSmallStep(int stepIndex, bool isActive) {
    return Container(
      width: 23,
      height: 22,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.primaryDark,
        borderRadius: BorderRadius.circular(11),
      ),
      alignment: Alignment.center,
      child: Text(
        '$stepIndex',
        style: AppTextStyles.labelXSmall.copyWith(
          color: isActive ? AppColors.textOnPrimary : AppColors.textLabel,
        ),
      ),
    );
  }
}
