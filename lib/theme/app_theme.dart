import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: AppTextStyles.titleLarge,
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
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.backgroundDeep,
          selectedItemColor: AppColors.navActive,
          unselectedItemColor: AppColors.navInactive,
          selectedLabelStyle: AppTextStyles.navLabel.copyWith(color: AppColors.navActive),
          unselectedLabelStyle: AppTextStyles.navLabel.copyWith(color: AppColors.navInactive),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.backgroundDeep,
          indicatorColor: AppColors.primaryFill,
          labelTextStyle: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? AppTextStyles.navLabel.copyWith(color: AppColors.navActive) : AppTextStyles.navLabel.copyWith(color: AppColors.navInactive)),
          iconTheme: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? const IconThemeData(color: AppColors.navActive, size: AppIconSize.nav) : const IconThemeData(color: AppColors.navInactive, size: AppIconSize.nav)),
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
}
