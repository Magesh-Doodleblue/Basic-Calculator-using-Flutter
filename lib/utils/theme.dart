import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: darkScaffoldBgColor,
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: whiteColor,
    displayColor: whiteColor,
  ),
  // textTheme: const TextTheme(
  //   titleLarge: TextStyle(
  //     color: whiteColor,
  //   ),
  //   bodyMedium: TextStyle(
  //     color: whiteColor,
  //   ),
  // ),
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: lightScaffoldBgColor,
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: blackColor,
    displayColor: blackColor,
  ),
  // textTheme: const TextTheme(
  //   titleLarge: TextStyle(
  //     color: blackColor,
  //   ),
  //   bodyMedium: TextStyle(
  //     color: blackColor,
  //   ),
  // ),
);
