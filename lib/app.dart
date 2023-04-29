// ignore_for_file: library_private_types_in_public_api

import 'package:calculator/utils/theme.dart';
import 'package:flutter/material.dart';
import 'views/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDarkEnable;

  @override
  void initState() {
    super.initState();
    isDarkEnable = widget.prefs.getBool('isDarkMode') ?? false;
  }

  void _toggleDarkMode() async {
    setState(() {
      isDarkEnable = !isDarkEnable;
      widget.prefs.setBool('isDarkMode', isDarkEnable);
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
