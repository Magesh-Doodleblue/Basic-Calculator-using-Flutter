import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class ThemeChange {
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkScaffoldBgColor,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.whiteColor,
      displayColor: AppColors.whiteColor,
    ),
  );

  final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightScaffoldBgColor,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.blackColor,
      displayColor: AppColors.blackColor,
    ),
  );
}
