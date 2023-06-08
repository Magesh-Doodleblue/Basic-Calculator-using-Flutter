// // ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'utils/notification_initialize.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  NotificationInitialize().notificatioCalling;
  //Calling the notification from another file
  runApp(MyApp(prefs: prefs));
}
