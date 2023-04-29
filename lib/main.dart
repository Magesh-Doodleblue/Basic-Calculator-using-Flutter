// // ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  runApp(MyApp(isDarkMode: isDarkMode));
}


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isDarkMode = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedPreference();
//   }

//   void _loadSavedPreference() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _isDarkMode = prefs.getBool('isDarkMode') ?? false;
//     });
//   }

//   void _toggleTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _isDarkMode = !_isDarkMode;
//       prefs.setBool('isDarkMode', _isDarkMode);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Light/Dark Mode'),
//         ),
//         body: Center(
//           child: IconButton(
//             icon: _isDarkMode ? Icon(Icons.nightlight_round) : Icon(Icons.wb_sunny),
//             onPressed: _toggleTheme,
//           ),
//         ),
//       ),
//     );
//   }
// }
