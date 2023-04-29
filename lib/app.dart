// ignore_for_file: library_private_types_in_public_api

import 'package:calculator/utils/theme.dart';
import 'package:flutter/material.dart';
import 'views/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  final bool isDarkMode;

  const MyApp({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDarkEnable;

  @override
  void initState() {
    super.initState();
    isDarkEnable = widget.isDarkMode;
  }

  void _toggleDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkEnable = !isDarkEnable;
      prefs.setBool('isDarkMode', isDarkEnable);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: isDarkEnable ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(
        toggleDarkMode: _toggleDarkMode,
        isDarkEnable: isDarkEnable,
      ),
    );
  }
}
