import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: const Color.fromARGB(255, 47, 215, 156),
        primaryContainer: Colors.teal[700]!,
        secondary: Colors.orange,
        secondaryContainer: const Color.fromARGB(255, 240, 239, 239),
        surface: Colors.white,
        error: const Color.fromARGB(255, 230, 62, 62),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue,
        textTheme: ButtonTextTheme.primary,
      ),
      fontFamily: "Poppins",
      textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          headlineMedium:
              TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54),
          bodySmall: TextStyle(fontSize: 14.0, color: Colors.black54),
          labelLarge:
              TextStyle(fontSize: 17.0, color: Color.fromARGB(255, 50, 50, 54)),
          labelMedium:
              TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 50, 50, 54)),
          labelSmall: TextStyle(
              fontSize: 11.0, color: Color.fromARGB(255, 138, 138, 138))),
    );
  }
}
