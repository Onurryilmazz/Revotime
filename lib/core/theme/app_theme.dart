import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF7FB1ED); // Daha soluk mavi
  static const Color _secondaryColor = Color(0xFF9CC2F0); // Daha da soluk mavi
  static const Color _accentColor = Color(0xFFB5D4F5); // En soluk mavi
  static const Color _backgroundColor = Color(0xFFF8F9FA); // Kirli beyaz
  static const Color _surfaceColor = Colors.white;
  static const Color _errorColor = Color(0xFFE57373);
  static const Color _primaryColorWithOpacity = Color(0x807FB1ED); // %50 opaklık
  static const Color _textColor = Color(0xFF2C3E50); // Koyu gri-siyah

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: _accentColor,
        background: _backgroundColor,
        surface: _surfaceColor,
        error: _errorColor,
        onBackground: _textColor,
        onSurface: _textColor,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: _textColor),
        headlineMedium: TextStyle(color: _textColor),
        headlineSmall: TextStyle(color: _textColor),
        titleLarge: TextStyle(color: _textColor),
        titleMedium: TextStyle(color: _textColor),
        titleSmall: TextStyle(color: _textColor),
        bodyLarge: TextStyle(color: _textColor),
        bodyMedium: TextStyle(color: _textColor),
        bodySmall: TextStyle(color: _textColor),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _backgroundColor,
        foregroundColor: _textColor,
        elevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColorWithOpacity),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      scaffoldBackgroundColor: _backgroundColor,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: _accentColor,
        background: const Color(0xFF1A1A1A),
        surface: const Color(0xFF2C2C2C),
        error: _errorColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF2C2C2C),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColorWithOpacity),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    );
  }
} 