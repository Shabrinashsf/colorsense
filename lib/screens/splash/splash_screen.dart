import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:colorsense/screens/onboarding/onboarding_welcome_screen.dart';
import 'package:colorsense/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// 01 - Splash Screen  |  Figma node: 4:2
// -----------------------------------------------------------------------------

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // Fullscreen immersive
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const OnboardingWelcomeScreen(),
          ),
        );
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSplash,
      body: SafeArea(
        top: false,
        bottom: false,
        child: SizedBox.expand(
          child: Column(
            children: [
              const SizedBox(height: 126),
              _HeroSection(),
              const Expanded(child: SizedBox()),
              _LoadingSection(animation: _progressAnimation),
              const Expanded(child: SizedBox()),
              const _CbPaletteBar(),
              const SizedBox(height: 38),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Hero Section: app icon + radial glow ellipse + title + subtitle
// -----------------------------------------------------------------------------

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              // Radial glow ellipse (behind icon + text)
              Container(
                width: 300,
                height: 188,
                margin: const EdgeInsets.only(top: 40),
                child: SvgPicture.asset(
                  'assets/images/ellipse.svg',
                  fit: BoxFit.contain,
                ),
              ),

              // Icon + title stacked
              Column(
                children: [
                  _AppIcon(),
                  const SizedBox(height: 16),
                  _TitleGroup(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// App Icon: 80x80 violet rounded square + 62x62 logo image
// -----------------------------------------------------------------------------

class _AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          // Violet background square
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadius.appIcon),
            ),
          ),
          // Logo image (9px inset)
          Positioned(
            left: 9,
            top: 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/app_logo.png',
                width: 62,
                height: 62,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _FallbackLogo(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Fallback when assets/images/app_logo.png is missing
class _FallbackLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        Icons.remove_red_eye_outlined,
        color: context.colors.textPrimary,
        size: 32,
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Title Group: "ColorSense" + subtitle
// -----------------------------------------------------------------------------

class _TitleGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 32px ExtraBold
        Text(
          'ColorSense',
          style: context.textStyles.displayLarge,
        ),
        const SizedBox(height: 5),
        // 12px Regular, lineHeight 19px, center
        SizedBox(
          width: 226,
          child: Text(
            'Membantu kamu memahami warna di sekitarmu',
            textAlign: TextAlign.center,
            style: context.textStyles.bodyMedium.copyWith(
              fontSize: 12,
              height: 19 / 12,
              color: context.colors.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Loading Section: animated circular progress + percentage + label
// -----------------------------------------------------------------------------

class _LoadingSection extends StatelessWidget {
  final Animation<double> animation;
  const _LoadingSection({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final percent = (animation.value * 100).round();
        return Column(
          children: [
            // Circle progress indicator (56x56)
            SizedBox(
              width: 56,
              height: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: CustomPaint(
                      painter: _CircularProgressPainter(
                        progress: animation.value,
                        trackColor: AppColors.primaryDark,
                        progressColor: AppColors.primary,
                        strokeWidth: 3.5,
                      ),
                    ),
                  ),
                  // Percentage text centered
                  Text(
                    '$percent%',
                    style: context.textStyles.progressLabel,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 21),

            // "Memuat warna..."
            Text(
              'Memuat warna...',
              style: context.textStyles.loadingText,
            ),
          ],
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
// Custom arc painter — starts at top (-pi/2), draws clockwise
// -----------------------------------------------------------------------------

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  const _CircularProgressPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_CircularProgressPainter old) =>
      old.progress != progress;
}

// -----------------------------------------------------------------------------
// CB-Safe Palette Bar: 7 colored strips (35x4dp), 2dp gap, from Figma
// -----------------------------------------------------------------------------

class _CbPaletteBar extends StatelessWidget {
  const _CbPaletteBar();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.cbSafePalette;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(colors.length, (i) {
        final isLast = i == colors.length - 1;
        return Container(
          width: 35,
          height: 4,
          margin: isLast
              ? EdgeInsets.zero
              : const EdgeInsets.only(right: 2.0),
          decoration: BoxDecoration(
            color: colors[i],
            borderRadius: AppRadius.barBR,
          ),
        );
      }),
    );
  }
}
