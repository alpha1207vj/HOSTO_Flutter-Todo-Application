import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.accentPink,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppFonts.inter, // Police par défaut
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: AppFonts.poppins,
          color: AppColors.textMain,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textMain,
        ),
      ),
      // Tu peux aussi définir le style de tes boutons ici !
    );
  }
}