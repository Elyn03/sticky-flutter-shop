import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 13, 54, 87),
        brightness: Brightness.light,
        primary: const Color.fromARGB(255, 13, 54, 87)
      ),
      
    );
  }
}
