import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xFF00FFAB),
      secondary: const Color(0xFF72FFFF),
      surface: const Color(0xFF00FFAB),
      background: Colors.white,
      onBackground: const Color(0xFF172774),
    ),
    scaffoldBackgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Color(0xFF172774)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Color(0xFF172774)),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Color(0xFF172774)),
      titleMedium: TextStyle(color: Color(0xFF172774)),
      titleSmall: TextStyle(color: Color(0xFF172774)),
      bodyLarge: TextStyle(color: Color(0xFF172774)),
      bodyMedium: TextStyle(color: Color(0xFF172774)),
      bodySmall: TextStyle(color: Color(0xFF172774)),
    ),
  );
}
