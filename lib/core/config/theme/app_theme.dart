import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF1E1E2C);
  static const Color _secondaryColor = Color(0xFF2D2D3A);
  static const Color _accentColor = Color(0xFF64FFDA);
  static const Color _errorColor = Color(0xFFCF6679);

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(
      primary: _accentColor,
      onPrimary: Colors.black,
      secondary: _accentColor,
      surface: _primaryColor,
      onSurface: Colors.white,
      error: _errorColor,
    ),

    scaffoldBackgroundColor: _primaryColor,

    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardThemeData(
      color: _secondaryColor,
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _accentColor,
      foregroundColor: Colors.black,
      elevation: 6,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _secondaryColor,
      labelStyle: const TextStyle(color: Colors.grey),
      floatingLabelStyle: const TextStyle(color: _accentColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _accentColor, width: 2),
      ),
    ),
  );
}
