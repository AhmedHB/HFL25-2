import 'package:flutter/material.dart';

class AppTheme {
  static const Color backgroundGreen = Color(0xFF86F77B);
  static const Color panelTop = Color(0xFF363B44);
  static const Color panelBottom = Color(0xFF22252B);

  // Operatorfärg
  static const Color operatorGreen = Color(0xFF7CFF73);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor: backgroundGreen,

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white70,
          textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),

      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        brightness: Brightness.dark,
      ),
    );
  }
}
