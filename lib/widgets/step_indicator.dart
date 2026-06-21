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
              final isCurrent = stepIndex == currentStep;
              
              return _buildStep(context, stepIndex, isCurrent);
            }),
          ),
        ],
      ),
    );
  }

  String _getStepTitle(int stepIndex) {
    switch (stepIndex) {
      case 1: return '1 \u2014 SELAMAT DATANG';
      case 2: return '2 \u2014 KONDISI DIRI';
      case 3: return '3 \u2014 KEPARAHAN';
      case 4: return '4 \u2014 PREFERENSI';
      default: return '$stepIndex';
    }
  }

  Widget _buildStep(BuildContext context, int stepIndex, bool isCurrent) {
    return Container(
      height: 22,
      width: isCurrent ? 118 : 23,
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.primary : AppColors.primaryDark,
        borderRadius: BorderRadius.circular(11),
      ),
      alignment: Alignment.center,
      child: Text(
        isCurrent ? _getStepTitle(stepIndex) : '$stepIndex',
        style: context.textStyles.labelXSmall.copyWith(
          color: isCurrent ? AppColors.textOnPrimary : AppColors.textLabel,
        ),
      ),
    );
  }
}
