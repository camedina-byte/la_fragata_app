import 'package:flutter/material.dart';

class TemaFragata {
  static const Color azulMarino     = Color(0xFF0D1B2A);
  static const Color azulMedio      = Color(0xFF1B4F72);
  static const Color dorado         = Color(0xFFD4A017);
  static const Color verdePagado    = Color(0xFF27AE60);
  static const Color rojoPendiente  = Color(0xFFE74C3C);
  static const Color naranjaVencido = Color(0xFFE67E22);

  static final ThemeData temaClaro = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: azulMarino,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    scaffoldBackgroundColor: const Color(0xFFF0F4F8),
    listTileTheme: const ListTileThemeData(
      textColor: azulMarino,
      iconColor: azulMedio,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: azulMarino,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );
}