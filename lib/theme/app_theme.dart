import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ---------------------------------------------------------------------------
// AppThemeColors — semantic colour token, resolved per theme
// ---------------------------------------------------------------------------
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.backgroundPrimary,
    required this.surfacePrimary,
    required this.surfaceSecondary,
    required this.surfaceActive,
    required this.borderDefault,
    required this.borderActive,
    required this.borderInput,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textLabel,
    required this.navbarBg,
    required this.navbarBorder,
    required this.navInactive,
    required this.sectionTitle,
  });

  final Color backgroundPrimary;
  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color surfaceActive;
  final Color borderDefault;
  final Color borderActive;
  final Color borderInput;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textLabel;
  final Color navbarBg;
  final Color navbarBorder;
  final Color navInactive;
  final Color sectionTitle;

  // ── Dark (default) ────────────────────────────────────────────────────
  static const AppThemeColors dark = AppThemeColors(
    backgroundPrimary: Color(0xFF0A0A14),
    surfacePrimary: Color(0xFF12121E),
    surfaceSecondary: Color(0xFF12121B),
    surfaceActive: Color(0xFF121126),
    borderDefault: Color(0xFF1E1E30),
    borderActive: Color(0xFF36327D),
    borderInput: Color(0x996C63FF),
    textPrimary: Color(0xFFF0F0FF),
    textSecondary: Color(0xFFD0D0F0),
    textMuted: Color(0xFFAFADDF),
    textLabel: Color(0xFF9D97FF),
    navbarBg: Color(0xFF09090F),
    navbarBorder: Color(0xFF9D97FF),
    navInactive: Color(0xFFFFFFFF),
    sectionTitle: Color(0xFF9D97FF),
  );

  // ── Light ─────────────────────────────────────────────────────────────
  static const AppThemeColors light = AppThemeColors(
    backgroundPrimary: Color(0xFFF5F5FF),
    surfacePrimary: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFF0F0FA),
    surfaceActive: Color(0xFFEAEAFF),
    borderDefault: Color(0xFFE0E0F0),
    borderActive: Color(0xFFB0A8FF),
    borderInput: Color(0x996C63FF),
    textPrimary: Color(0xFF1A1A2E),
    textSecondary: Color(0xFF3A3A5C),
    textMuted: Color(0xFF8080A0),
    textLabel: Color(0xFF6C63FF),
    navbarBg: Color(0xFFFFFFFF),
    navbarBorder: Color(0xFFE0E0F0),
    navInactive: Color(0xFF8080A0),
    sectionTitle: Color(0xFF6C6C75),
  );

  @override
  AppThemeColors copyWith({
    Color? backgroundPrimary,
    Color? surfacePrimary,
    Color? surfaceSecondary,
    Color? surfaceActive,
    Color? borderDefault,
    Color? borderActive,
    Color? borderInput,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textLabel,
    Color? navbarBg,
    Color? navbarBorder,
    Color? navInactive,
    Color? sectionTitle,
  }) {
    return AppThemeColors(
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceActive: surfaceActive ?? this.surfaceActive,
      borderDefault: borderDefault ?? this.borderDefault,
      borderActive: borderActive ?? this.borderActive,
      borderInput: borderInput ?? this.borderInput,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      textLabel: textLabel ?? this.textLabel,
      navbarBg: navbarBg ?? this.navbarBg,
      navbarBorder: navbarBorder ?? this.navbarBorder,
      navInactive: navInactive ?? this.navInactive,
      sectionTitle: sectionTitle ?? this.sectionTitle,
    );
  }

  @override
  AppThemeColors lerp(AppThemeColors? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      backgroundPrimary: Color.lerp(backgroundPrimary, other.backgroundPrimary, t)!,
      surfacePrimary: Color.lerp(surfacePrimary, other.surfacePrimary, t)!,
      surfaceSecondary: Color.lerp(surfaceSecondary, other.surfaceSecondary, t)!,
      surfaceActive: Color.lerp(surfaceActive, other.surfaceActive, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderActive: Color.lerp(borderActive, other.borderActive, t)!,
      borderInput: Color.lerp(borderInput, other.borderInput, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textLabel: Color.lerp(textLabel, other.textLabel, t)!,
      navbarBg: Color.lerp(navbarBg, other.navbarBg, t)!,
      navbarBorder: Color.lerp(navbarBorder, other.navbarBorder, t)!,
      navInactive: Color.lerp(navInactive, other.navInactive, t)!,
      sectionTitle: Color.lerp(sectionTitle, other.sectionTitle, t)!,
    );
  }
}

// Convenient BuildContext extension
extension AppThemeContext on BuildContext {
  AppThemeColors get colors =>
      Theme.of(this).extension<AppThemeColors>() ?? AppThemeColors.dark;
}

class AppColors {
  AppColors._();
  static const Color backgroundDeep = Color(0xFF09090F);
  static const Color backgroundPrimary = Color(0xFF0A0A14);
  static const Color backgroundSplash = Color(0xFF080810);
  static const Color surfacePrimary = Color(0xFF12121E);
  static const Color surfaceSecondary = Color(0xFF12121B);
  static const Color surfaceActive = Color(0xFF121126);
  static const Color borderDefault = Color(0xFF1E1E30);
  static const Color borderActive = Color(0xFF36327D);
  static const Color borderInput = Color(0x996C63FF);
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF3B368A);
  static const Color primaryLight = Color(0xFF9D97FF);
  static const Color primaryFill = Color(0x146C63FF);
  static const Color textPrimary = Color(0xFFF0F0FF);
  static const Color textSecondary = Color(0xFFD0D0F0);
  static const Color textTertiary = Color(0xFFC0C0E0);
  static const Color textMuted = Color(0xFFAFADDF);
  static const Color textLabel = Color(0xFF9D97FF);
  static const Color textOnPrimary = Color(0xFF161531);
  static const Color success = Color(0xFF27AE60);
  static const Color info = Color(0xFF2980B9);
  static const Color warning = Color(0xFFE69F00);
  static const Color error = Color(0xFFD55E00);
  static const Color navbarBorder = Color(0xFF9D97FF);
  static const Color navActive = Color(0xFF6C63FF);
  static const Color navInactive = Color(0xFFFFFFFF);
  static const Color cbOrange = Color(0xFFE69F00);
  static const Color cbSkyBlue = Color(0xFF56B4E9);
  static const Color cbGreen = Color(0xFF009E73);
  static const Color cbYellow = Color(0xFFF0E442);
  static const Color cbBlue = Color(0xFF0072B2);
  static const Color cbVermillion = Color(0xFFD55E00);
  static const Color cbPink = Color(0xFFCC79A7);
  static const List<Color> cbSafePalette = [
    cbOrange, cbSkyBlue, cbGreen, cbYellow, cbBlue, cbVermillion, cbPink,
  ];
  static const Color divider = Color(0xFF1E1E30);
}

class AppTextStyles {
  AppTextStyles._();
  static TextStyle get displayLarge => GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.textPrimary);
  static TextStyle get headlineLarge => GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary, height: 32 / 24);
  static TextStyle get headlineMedium => GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary);
  static TextStyle get headlineSmall => GoogleFonts.plusJakartaSans(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textPrimary, height: 22 / 17);
  static TextStyle get titleLarge => GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary);
  static TextStyle get titleMedium => GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static TextStyle get titleSmall => GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary);
  static TextStyle get bodyLarge => GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textMuted, height: 1.5);
  static TextStyle get bodyMedium => GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textMuted, height: 19 / 12);
  static TextStyle get bodySmall => GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textMuted, height: 17 / 11);
  static TextStyle get labelLarge => GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary);
  static TextStyle get labelMedium => GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textLabel, letterSpacing: 1.0);
  static TextStyle get labelSmall => GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.textMuted);
  static TextStyle get labelXSmall => GoogleFonts.plusJakartaSans(fontSize: 8, fontWeight: FontWeight.w700, color: AppColors.textLabel, letterSpacing: 0.8);
  static TextStyle get labelXSmallOnPrimary => GoogleFonts.plusJakartaSans(fontSize: 8, fontWeight: FontWeight.w600, color: AppColors.textOnPrimary, letterSpacing: 0.8);
  static TextStyle get buttonPrimary => GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary);
  static TextStyle get buttonSecondary => GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary);
  static TextStyle get progressLabel => GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary);
  static TextStyle get loadingText => GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.primaryLight);
  static TextStyle get navLabel => GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w400);
  static TextStyle get answerNumber => GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary);
  static TextStyle get colorName => GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static TextStyle get colorCode => GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textMuted);
  static TextStyle get confidenceScore => GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textLabel);
}

extension AppTextStylesExt on BuildContext {
  AppTextTheme get textStyles => AppTextTheme(this);
}

class AppTextTheme {
  final BuildContext context;
  AppTextTheme(this.context);

  TextStyle get displayLarge => GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w800, color: context.colors.textPrimary);
  TextStyle get headlineLarge => GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w800, color: context.colors.textPrimary, height: 32 / 24);
  TextStyle get headlineMedium => GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w800, color: context.colors.textPrimary);
  TextStyle get headlineSmall => GoogleFonts.plusJakartaSans(fontSize: 17, fontWeight: FontWeight.w800, color: context.colors.textPrimary, height: 22 / 17);
  TextStyle get titleLarge => GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: context.colors.textPrimary);
  TextStyle get titleMedium => GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600, color: context.colors.textPrimary);
  TextStyle get titleSmall => GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600, color: context.colors.textSecondary);
  TextStyle get bodyLarge => GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w400, color: context.colors.textMuted, height: 1.5);
  TextStyle get bodyMedium => GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w400, color: context.colors.textMuted, height: 19 / 12);
  TextStyle get bodySmall => GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w400, color: context.colors.textMuted, height: 17 / 11);
  TextStyle get labelLarge => GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w700, color: context.colors.textPrimary);
  TextStyle get labelMedium => GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w600, color: context.colors.textLabel, letterSpacing: 1.0);
  TextStyle get labelSmall => GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w400, color: context.colors.textMuted);
  TextStyle get labelXSmall => GoogleFonts.plusJakartaSans(fontSize: 8, fontWeight: FontWeight.w700, color: context.colors.textLabel, letterSpacing: 0.8);
  TextStyle get labelXSmallOnPrimary => GoogleFonts.plusJakartaSans(fontSize: 8, fontWeight: FontWeight.w600, color: AppColors.textOnPrimary, letterSpacing: 0.8);
  TextStyle get buttonPrimary => GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: context.colors.textPrimary);
  TextStyle get buttonSecondary => GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary);
  TextStyle get progressLabel => GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary);
  TextStyle get loadingText => GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.primaryLight);
  TextStyle get navLabel => GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w400);
  TextStyle get answerNumber => GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: context.colors.textPrimary);
  TextStyle get colorName => GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600, color: context.colors.textPrimary);
  TextStyle get colorCode => GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w400, color: context.colors.textMuted);
  TextStyle get confidenceScore => GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w400, color: context.colors.textLabel);
}

class AppSpacing {
  AppSpacing._();
  static const double xs2 = 2.0;
  static const double xs = 3.0;
  static const double sm2 = 5.0;
  static const double sm = 8.0;
  static const double md = 10.0;
  static const double md2 = 12.0;
  static const double md3 = 14.0;
  static const double lg = 15.0;
  static const double screenH = 20.0;
  static const double xxl = 32.0;
  static const double screenV = 40.0;
  static const double statusBar = 50.0;
}

class AppRadius {
  AppRadius._();
  static const double bar = 2.0;
  static const double colorChip = 6.0;
  static const double cardSm = 9.0;
  static const double cardMd = 11.0;
  static const double cardLg = 13.0;
  static const double button = 14.0;
  static const double pill = 11.0;
  static const double appIcon = 28.0;
  static BorderRadius get barBR => BorderRadius.circular(bar);
  static BorderRadius get colorChipBR => BorderRadius.circular(colorChip);
  static BorderRadius get cardSmBR => BorderRadius.circular(cardSm);
  static BorderRadius get cardMdBR => BorderRadius.circular(cardMd);
  static BorderRadius get cardLgBR => BorderRadius.circular(cardLg);
  static BorderRadius get buttonBR => BorderRadius.circular(button);
  static BorderRadius get pillBR => BorderRadius.circular(pill);
  static BorderRadius get appIconBR => BorderRadius.circular(appIcon);
}

class AppShadows {
  AppShadows._();
  static List<BoxShadow> get cardShadow => [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))];
  static List<BoxShadow> get primaryGlow => [BoxShadow(color: AppColors.primary.withValues(alpha: 0.35), blurRadius: 20, spreadRadius: 0, offset: const Offset(0, 6))];
}

class AppIconSize {
  AppIconSize._();
  static const double nav = 24.0;
  static const double card = 24.0;
  static const double feature = 27.0;
  static const double avatar = 30.0;
  static const double radioOuter = 14.0;
  static const double dot = 8.0;
  static const double notification = 24.0;
}

class AppTheme {
  AppTheme._();

  static const ColorScheme _colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.textPrimary,
    primaryContainer: AppColors.primaryDark,
    onPrimaryContainer: AppColors.primaryLight,
    secondary: AppColors.primaryLight,
    onSecondary: AppColors.textOnPrimary,
    secondaryContainer: AppColors.primaryFill,
    onSecondaryContainer: AppColors.textPrimary,
    tertiary: AppColors.cbSkyBlue,
    onTertiary: AppColors.textPrimary,
    error: AppColors.error,
    onError: AppColors.textPrimary,
    surface: AppColors.surfacePrimary,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textMuted,
    outline: AppColors.borderDefault,
    outlineVariant: AppColors.borderActive,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: AppColors.textPrimary,
    onInverseSurface: AppColors.backgroundPrimary,
    inversePrimary: AppColors.primaryDark,
  );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: _colorScheme,
        scaffoldBackgroundColor: AppColors.backgroundPrimary,
        extensions: const <ThemeExtension<dynamic>>[
          AppThemeColors.dark,
        ],
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: AppTextStyles.headlineMedium,
          iconTheme: const IconThemeData(color: AppColors.textPrimary, size: AppIconSize.nav),
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyles.displayLarge,
          headlineLarge: AppTextStyles.headlineLarge,
          headlineMedium: AppTextStyles.headlineMedium,
          headlineSmall: AppTextStyles.headlineSmall,
          titleLarge: AppTextStyles.titleLarge,
          titleMedium: AppTextStyles.titleMedium,
          titleSmall: AppTextStyles.titleSmall,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
          labelLarge: AppTextStyles.labelLarge,
          labelMedium: AppTextStyles.labelMedium,
          labelSmall: AppTextStyles.labelSmall,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textPrimary,
            minimumSize: const Size.fromHeight(46),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonBR),
            textStyle: AppTextStyles.buttonPrimary,
            elevation: 0,
          ),
        ),
        textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: AppColors.primary, textStyle: AppTextStyles.buttonSecondary)),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            minimumSize: const Size.fromHeight(46),
            side: const BorderSide(color: AppColors.borderActive, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonBR),
            textStyle: AppTextStyles.buttonSecondary,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.primaryFill,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md3, vertical: AppSpacing.md2),
          border: OutlineInputBorder(borderRadius: AppRadius.cardMdBR, borderSide: const BorderSide(color: AppColors.borderInput, width: 1.5)),
          enabledBorder: OutlineInputBorder(borderRadius: AppRadius.cardMdBR, borderSide: const BorderSide(color: AppColors.borderInput, width: 1.5)),
          focusedBorder: OutlineInputBorder(borderRadius: AppRadius.cardMdBR, borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
          hintStyle: AppTextStyles.bodyMedium,
          labelStyle: AppTextStyles.labelMedium,
        ),
        cardTheme: CardThemeData(
          color: AppColors.surfacePrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.cardMdBR, side: const BorderSide(color: AppColors.borderDefault, width: 1.5)),
          margin: EdgeInsets.zero,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.primaryDark,
          selectedColor: AppColors.primary,
          labelStyle: AppTextStyles.labelXSmall,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.pillBR),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? AppColors.textPrimary : AppColors.textMuted),
          trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? AppColors.primary : AppColors.borderDefault),
        ),
        radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? AppColors.primary : AppColors.borderDefault)),
        dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1, space: 0),
        iconTheme: const IconThemeData(color: AppColors.primaryLight, size: AppIconSize.card),
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.primary, circularTrackColor: AppColors.primaryDark, linearTrackColor: AppColors.primaryDark),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.surfacePrimary,
          contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.cardMdBR),
          behavior: SnackBarBehavior.floating,
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.surfaceSecondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xxl)),
          titleTextStyle: AppTextStyles.headlineSmall,
          contentTextStyle: AppTextStyles.bodyMedium,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.surfaceSecondary,
          modalBackgroundColor: AppColors.surfaceSecondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.xxl))),
          elevation: 0,
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(color: AppColors.surfaceActive, borderRadius: AppRadius.cardSmBR),
          textStyle: AppTextStyles.labelSmall,
        ),
      );

  // ── Light Theme ────────────────────────────────────────────────────────
  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Color(0xFFF0F0FF),
    primaryContainer: Color(0xFFD8D6FF),
    onPrimaryContainer: Color(0xFF1A1050),
    secondary: AppColors.primaryLight,
    onSecondary: Color(0xFF161531),
    secondaryContainer: Color(0xFFEAEAFF),
    onSecondaryContainer: Color(0xFF1A1A2E),
    tertiary: AppColors.cbSkyBlue,
    onTertiary: Color(0xFF1A1A2E),
    error: AppColors.error,
    onError: Color(0xFFF0F0FF),
    surface: Color(0xFFF0F0FA),
    onSurface: Color(0xFF1A1A2E),
    onSurfaceVariant: Color(0xFF8080A0),
    outline: Color(0xFFE0E0F0),
    outlineVariant: Color(0xFFB0A8FF),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFF1A1A2E),
    onInverseSurface: Color(0xFFF5F5FF),
    inversePrimary: AppColors.primaryDark,
  );

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: _lightColorScheme,
        scaffoldBackgroundColor: const Color(0xFFF5F5FF),
        extensions: const <ThemeExtension<dynamic>>[
          AppThemeColors.light,
        ],
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F5FF),
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Color(0xFF1A1A2E), size: AppIconSize.nav),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w800, color: const Color(0xFF1A1A2E)),
          headlineLarge: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF1A1A2E), height: 32 / 24),
          headlineMedium: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w800, color: const Color(0xFF1A1A2E)),
          headlineSmall: GoogleFonts.plusJakartaSans(fontSize: 17, fontWeight: FontWeight.w800, color: const Color(0xFF1A1A2E), height: 22 / 17),
          titleLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E)),
          titleMedium: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E)),
          titleSmall: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF3A3A5C)),
          bodyLarge: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF8080A0), height: 1.5),
          bodyMedium: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w400, color: const Color(0xFF8080A0), height: 19 / 12),
          bodySmall: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w400, color: const Color(0xFF8080A0), height: 17 / 11),
          labelLarge: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E)),
          labelMedium: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary, letterSpacing: 1.0),
          labelSmall: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xFF8080A0)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: const Color(0xFFF0F0FF),
            minimumSize: const Size.fromHeight(46),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonBR),
            elevation: 0,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFEAEAFF),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md3, vertical: AppSpacing.md2),
          border: OutlineInputBorder(borderRadius: AppRadius.cardMdBR, borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 1.5)),
          enabledBorder: OutlineInputBorder(borderRadius: AppRadius.cardMdBR, borderSide: const BorderSide(color: Color(0xFFB0A8FF), width: 1.5)),
          focusedBorder: OutlineInputBorder(borderRadius: AppRadius.cardMdBR, borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
          hintStyle: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF8080A0)),
          labelStyle: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.primary),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFFFFFFFF),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.cardMdBR, side: const BorderSide(color: Color(0xFFE0E0F0), width: 1.5)),
          margin: EdgeInsets.zero,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? Colors.white : Colors.grey.shade400),
          trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? AppColors.primary : const Color(0xFFD0D0E0)),
        ),
        dividerTheme: const DividerThemeData(color: Color(0xFFE0E0F0), thickness: 1, space: 0),
        iconTheme: const IconThemeData(color: AppColors.primary, size: AppIconSize.card),
        dialogTheme: DialogThemeData(
          backgroundColor: const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xxl)),
          titleTextStyle: GoogleFonts.plusJakartaSans(fontSize: 17, fontWeight: FontWeight.w800, color: const Color(0xFF1A1A2E)),
          contentTextStyle: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF8080A0)),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xFFFFFFFF),
          modalBackgroundColor: Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.xxl))),
          elevation: 0,
        ),
      );
}
