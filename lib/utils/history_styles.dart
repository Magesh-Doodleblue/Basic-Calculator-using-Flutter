import 'package:flutter/material.dart';

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
