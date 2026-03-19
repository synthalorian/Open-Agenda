import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

/// Open Agenda Theme System
/// Neon synthwave aesthetic with modern Material Design 3
class AppTheme {
  AppTheme._();

  // Typography
  static const String _fontFamily = 'Roboto';

  static TextTheme get _textTheme => const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.16,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.22,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.25,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.29,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.33,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.27,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          height: 1.50,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.50,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          height: 1.33,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          height: 1.45,
        ),
      );

  /// Dark Theme (Primary)
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        fontFamily: _fontFamily,
        colorScheme: DarkColorScheme(),
        textTheme: _textTheme.apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
        scaffoldBackgroundColor: AppColors.darkBackground,
        appBarTheme: AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.textPrimary,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle: _textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: const IconThemeData(color: AppColors.textPrimary),
        ),
        cardTheme: CardTheme(
          color: AppColors.darkCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.glassBorder, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.neonPink,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: _textTheme.labelLarge,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.neonPink,
            side: const BorderSide(color: AppColors.neonPink, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: _textTheme.labelLarge,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.neonCyan,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: _textTheme.labelLarge,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.neonPink,
          foregroundColor: AppColors.textPrimary,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkCard,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.glassBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.glassBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.neonCyan, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          labelStyle: _textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
          hintStyle: _textTheme.bodyMedium?.copyWith(
            color: AppColors.textTertiary,
          ),
          prefixIconColor: AppColors.textSecondary,
          suffixIconColor: AppColors.textSecondary,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.darkCard,
          selectedColor: AppColors.neonPink,
          disabledColor: AppColors.darkElevated,
          labelStyle: _textTheme.labelMedium,
          secondaryLabelStyle: _textTheme.labelMedium,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.glassBorder),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.glassBorder,
          thickness: 1,
          space: 24,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkSurface,
          selectedItemColor: AppColors.neonPink,
          unselectedItemColor: AppColors.textTertiary,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: _textTheme.labelSmall,
          unselectedLabelStyle: _textTheme.labelSmall,
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: AppColors.darkSurface,
          selectedIconTheme: const IconThemeData(color: AppColors.neonPink),
          unselectedIconTheme: const IconThemeData(color: AppColors.textTertiary),
          selectedLabelTextStyle: _textTheme.labelSmall?.copyWith(
            color: AppColors.neonPink,
          ),
          unselectedLabelTextStyle: _textTheme.labelSmall?.copyWith(
            color: AppColors.textTertiary,
          ),
          elevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.darkSurface,
          indicatorColor: AppColors.neonPink.withOpacity(0.2),
          elevation: 0,
          height: 80,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _textTheme.labelSmall?.copyWith(color: AppColors.neonPink);
            }
            return _textTheme.labelSmall?.copyWith(color: AppColors.textTertiary);
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.neonPink);
            }
            return const IconThemeData(color: AppColors.textTertiary);
          }),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.darkSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: AppColors.darkSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          titleTextStyle: _textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
          ),
          contentTextStyle: _textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.darkElevated,
          contentTextStyle: _textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: AppColors.neonPink,
          unselectedLabelColor: AppColors.textTertiary,
          labelStyle: _textTheme.labelLarge,
          unselectedLabelStyle: _textTheme.labelLarge,
          indicator: BoxDecoration(
            border: const Border(
              bottom: BorderSide(color: AppColors.neonPink, width: 3),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: Colors.transparent,
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: AppColors.neonPink,
          inactiveTrackColor: AppColors.darkElevated,
          thumbColor: AppColors.neonPink,
          overlayColor: AppColors.neonPink.withOpacity(0.2),
          valueIndicatorColor: AppColors.neonPink,
          valueIndicatorTextStyle: _textTheme.labelSmall?.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.neonPink;
            }
            return AppColors.textTertiary;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.neonPink.withOpacity(0.5);
            }
            return AppColors.darkElevated;
          }),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.neonPink;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(AppColors.textPrimary),
          side: const BorderSide(color: AppColors.glassBorder, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.neonPink;
            }
            return AppColors.textTertiary;
          }),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.neonPink,
          linearTrackColor: AppColors.darkElevated,
          circularTrackColor: AppColors.darkElevated,
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: AppColors.darkElevated,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.glassBorder),
          ),
          textStyle: _textTheme.bodySmall?.copyWith(color: AppColors.textPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      );

  /// Light Theme
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: _fontFamily,
        colorScheme: LightColorScheme(),
        textTheme: _textTheme.apply(
          bodyColor: AppColors.textDark,
          displayColor: AppColors.textDark,
        ),
        scaffoldBackgroundColor: AppColors.lightBackground,
        appBarTheme: AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.lightSurface,
          foregroundColor: AppColors.textDark,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleTextStyle: _textTheme.titleLarge?.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: const IconThemeData(color: AppColors.textDark),
        ),
        cardTheme: CardTheme(
          color: AppColors.lightCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: const Color(0x11000000), width: 1),
          ),
          clipBehavior: Clip.antiAlias,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.neonPink,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: _textTheme.labelLarge,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.neonPink,
            side: const BorderSide(color: AppColors.neonPink, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: _textTheme.labelLarge,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.neonCyan,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: _textTheme.labelLarge,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.neonPink,
          foregroundColor: AppColors.textPrimary,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightCard,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0x11000000)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0x11000000)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.neonCyan, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          labelStyle: _textTheme.bodyMedium?.copyWith(
            color: AppColors.textDarkSecondary,
          ),
          hintStyle: _textTheme.bodyMedium?.copyWith(
            color: AppColors.textDarkSecondary.withOpacity(0.6),
          ),
          prefixIconColor: AppColors.textDarkSecondary,
          suffixIconColor: AppColors.textDarkSecondary,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.lightCard,
          selectedColor: AppColors.neonPink,
          disabledColor: AppColors.lightElevated,
          labelStyle: _textTheme.labelMedium?.copyWith(color: AppColors.textDark),
          secondaryLabelStyle: _textTheme.labelMedium?.copyWith(color: AppColors.textDark),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0x11000000)),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0x11000000),
          thickness: 1,
          space: 24,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.lightSurface,
          selectedItemColor: AppColors.neonPink,
          unselectedItemColor: AppColors.textDarkSecondary,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: _textTheme.labelSmall?.copyWith(color: AppColors.textDark),
          unselectedLabelStyle: _textTheme.labelSmall?.copyWith(color: AppColors.textDark),
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: AppColors.lightSurface,
          selectedIconTheme: const IconThemeData(color: AppColors.neonPink),
          unselectedIconTheme: const IconThemeData(color: AppColors.textDarkSecondary),
          selectedLabelTextStyle: _textTheme.labelSmall?.copyWith(
            color: AppColors.neonPink,
          ),
          unselectedLabelTextStyle: _textTheme.labelSmall?.copyWith(
            color: AppColors.textDarkSecondary,
          ),
          elevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.lightSurface,
          indicatorColor: AppColors.neonPink.withOpacity(0.15),
          elevation: 0,
          height: 80,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _textTheme.labelSmall?.copyWith(color: AppColors.neonPink);
            }
            return _textTheme.labelSmall?.copyWith(color: AppColors.textDarkSecondary);
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.neonPink);
            }
            return const IconThemeData(color: AppColors.textDarkSecondary);
          }),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.lightSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: AppColors.lightSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          titleTextStyle: _textTheme.titleLarge?.copyWith(
            color: AppColors.textDark,
          ),
          contentTextStyle: _textTheme.bodyMedium?.copyWith(
            color: AppColors.textDarkSecondary,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.darkElevated,
          contentTextStyle: _textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: AppColors.neonPink,
          unselectedLabelColor: AppColors.textDarkSecondary,
          labelStyle: _textTheme.labelLarge?.copyWith(color: AppColors.textDark),
          unselectedLabelStyle: _textTheme.labelLarge?.copyWith(color: AppColors.textDark),
          indicator: BoxDecoration(
            border: const Border(
              bottom: BorderSide(color: AppColors.neonPink, width: 3),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: Colors.transparent,
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: AppColors.neonPink,
          inactiveTrackColor: AppColors.lightElevated,
          thumbColor: AppColors.neonPink,
          overlayColor: AppColors.neonPink.withOpacity(0.15),
          valueIndicatorColor: AppColors.neonPink,
          valueIndicatorTextStyle: _textTheme.labelSmall?.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.neonPink;
            }
            return AppColors.textDarkSecondary;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.neonPink.withOpacity(0.5);
            }
            return AppColors.lightElevated;
          }),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.neonPink;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(AppColors.textPrimary),
          side: const BorderSide(color: Color(0x33000000), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.neonPink;
            }
            return AppColors.textDarkSecondary;
          }),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.neonPink,
          linearTrackColor: AppColors.lightElevated,
          circularTrackColor: AppColors.lightElevated,
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: AppColors.darkElevated,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.glassBorder),
          ),
          textStyle: _textTheme.bodySmall?.copyWith(color: AppColors.textPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      );
}
