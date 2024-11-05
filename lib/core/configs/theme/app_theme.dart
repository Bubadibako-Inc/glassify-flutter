import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    fontFamily: 'SF Pro Display',
    scaffoldBackgroundColor: AppColors.neutral100,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),
      filled: true,
      fillColor: AppColors.neutral50,
      labelStyle: const TextStyle(
        color: AppColors.neutral500,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelStyle: const TextStyle(
        color: AppColors.black,
        fontSize: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColors.red600,
          style: BorderStyle.solid,
          width: 4,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColors.black,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColors.red300,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColors.red500,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
    ),
  );
}
