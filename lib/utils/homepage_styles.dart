import 'package:flutter/material.dart';

BoxDecoration gridContainerDecoration(BuildContext context) {
  final theme = Theme.of(context);
  return BoxDecoration(
    border: Border.all(
      width: 1,
      color: theme.brightness == Brightness.dark
          ? Colors.white.withOpacity(0.2)
          : Colors.black.withOpacity(0.2),
    ),
  );
}
