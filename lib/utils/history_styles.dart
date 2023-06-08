import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

Text listSubTextForHistory(Map<String, String> calculation) {
  return Text(
    calculation["result"]!,
    style: styleFont(16),
  );
}

Text listTextForHistory(Map<String, String> calculation) {
  return Text(
    calculation["text"]!,
    style: styleFont(18),
  );
}

BoxDecoration containerDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(9),
    color: Colors.grey.withOpacity(0.32),
  );
}

TextStyle styleFont(int size) {
  return TextStyle(
    fontSize: size.toDouble(),
  );
}

TextStyle dialogTextStyle(BuildContext context, double size) {
  return GoogleFonts.poppins(
    color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.whiteColor
        : AppColors.blackColor,
    fontSize: size,
  );
}
