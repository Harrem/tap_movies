import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tap_movies/app/theme/app_colors.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData lightTheme = _buildLightTheme();
  static final ThemeData darkTheme = _buildDarkTheme();

  static ThemeData _buildLightTheme() {
    final colorScheme = const ColorScheme(
      brightness: Brightness.light,

      primary: AppColors.blue,
      onPrimary: Colors.white,

      secondary: AppColors.orange,
      onSecondary: Colors.white,

      tertiary: AppColors.amber,
      onTertiary: AppColors.navy,

      error: AppColors.error,
      onError: Colors.white,

      surface: AppColors.lightSurface,
      onSurface: AppColors.textPrimary,

      surfaceContainerHighest: AppColors.lightSurfaceElevated,
      outline: AppColors.lightBorder,
    );

    final textTheme = _textTheme(
      Brightness.light,
      color: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,

      scaffoldBackgroundColor: AppColors.lightBackground,

      fontFamily: GoogleFonts.inter().fontFamily,
      textTheme: textTheme,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.spaceGrotesk(
          fontSize: 21,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.lightBorder),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurfaceElevated,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.blue, width: 1.5),
        ),

        hintStyle: const TextStyle(color: AppColors.textMuted),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,

          minimumSize: const Size(double.infinity, 52),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),

          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.blue,

          minimumSize: const Size(double.infinity, 40),

          side: const BorderSide(color: AppColors.blue),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),

          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.blue,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        indicatorColor: AppColors.blue.withValues(alpha: 0.12),

        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightSurfaceElevated,
        selectedColor: AppColors.blue.withValues(alpha: 0.12),
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static ThemeData _buildDarkTheme() {
    final colorScheme = const ColorScheme(
      brightness: Brightness.dark,

      primary: AppColors.blue,
      onPrimary: Colors.white,

      secondary: AppColors.orange,
      onSecondary: Colors.white,

      tertiary: AppColors.amber,
      onTertiary: AppColors.navy,

      error: AppColors.error,
      onError: Colors.white,

      surface: AppColors.darkSurface,
      onSurface: AppColors.white,

      surfaceContainerHighest: AppColors.darkSurfaceElevated,
      outline: AppColors.darkBorder,
    );

    final textTheme = _textTheme(Brightness.dark, color: AppColors.white);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,

      scaffoldBackgroundColor: AppColors.darkBackground,

      fontFamily: GoogleFonts.inter().fontFamily,
      textTheme: textTheme,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,

        titleTextStyle: GoogleFonts.spaceGrotesk(
          fontSize: 21,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        margin: EdgeInsets.zero,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceElevated,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.blue, width: 1.5),
        ),

        hintStyle: const TextStyle(color: AppColors.textMuted),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,

          minimumSize: const Size(double.infinity, 52),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),

          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.blueLight,
          minimumSize: const Size(double.infinity, 52),

          side: const BorderSide(color: AppColors.blue),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),

          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.blueLight,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,

        indicatorColor: AppColors.blue.withValues(alpha: 0.18),

        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSurfaceElevated,
        selectedColor: AppColors.blue.withValues(alpha: 0.18),

        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static TextTheme _textTheme(Brightness brightness, {required Color color}) {
    final base = GoogleFonts.interTextTheme(
      brightness == Brightness.dark
          ? ThemeData.dark().textTheme
          : ThemeData.light().textTheme,
    );

    return base.copyWith(
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 38,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.2,
        color: color,
      ),

      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        color: color,
      ),

      headlineLarge: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: color,
      ),

      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
      ),

      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      ),

      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      ),

      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color,
      ),

      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: color,
      ),

      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: brightness == Brightness.dark
            ? AppColors.textMuted
            : AppColors.textSecondary,
      ),

      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}
