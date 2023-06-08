// // ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel', // 'important_channel
        channelName: 'Basic Notifications', //any name of the channel
        channelDescription:
            'Notification channel for basic notifications', //any description of the channel
        defaultColor: Colors.teal,
        ledColor: Colors.teal,
      ),
    ],
  );
  runApp(MyApp(prefs: prefs));
}
