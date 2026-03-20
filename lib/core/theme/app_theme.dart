import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF5B8DEF);
  static const Color primaryDark = Color(0xFF4A7ADE);

  // Light Theme colors
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightAppBar = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1A1A2E);
  static const Color lightSubText = Color(0xFF6B7280);
  static const Color lightUserBubble = Color(0xFF5B8DEF);
  static const Color lightAssistantBubble = Color(0xFFEEEEEE);
  static const Color lightInputField = Color(0xFFEEEEEE);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F0F1A);
  static const Color darkSurface = Color(0xFF1A1A2E);
  static const Color darkAppBar = Color(0xFF1A1A2E);
  static const Color darkText = Color(0xFFEAEAEA);
  static const Color darkSubText = Color(0xFF9CA3AF);
  static const Color darkUserBubble = Color(0xFF5B8DEF);
  static const Color darkAssistantBubble = Color(0xFF252538);
  static const Color darkInputField = Color(0xFF252538);
  static const Color darkBottomNav = Color(0xFF1E1E2E);

  // Light Themedata
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: primary,
      colorScheme: const ColorScheme.light(
        primary: primary,
        surface: lightSurface,
        onPrimary: Colors.white,
        onSurface: lightText,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightAppBar,
        foregroundColor: lightText,
        elevation: 0,
        centerTitle: false,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightSurface,
        selectedItemColor: primary,
        unselectedItemColor: Color(0xFF9CA3AF),
        elevation: 8,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightInputField,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: lightText),
        bodyMedium: TextStyle(color: lightText),
        bodySmall: TextStyle(color: lightSubText),
      ),
    );
  }

  // Dark ThemeData
  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        surface: darkSurface,
        onPrimary: Colors.white,
        onSurface: darkText,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkAppBar,
        foregroundColor: darkText,
        elevation: 0,
        centerTitle: false,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkBottomNav,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF6B7280),
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkInputField,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: Color(0xFF6B7280)),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: darkText),
        bodyMedium: TextStyle(color: darkText),
        bodySmall: TextStyle(color: darkSubText),
      ),
    );
  }
}