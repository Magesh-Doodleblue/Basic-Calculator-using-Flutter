import 'package:awesome_notifications/awesome_notifications.dart';

import 'colors.dart';

class NotificationInitialize {
  notificatioCalling() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel', // 'important_channel
          channelName: 'Basic Notifications', //any name of the channel
          channelDescription:
              'Notification channel for basic notifications', //any description of the channel
          defaultColor: AppColors.blackColor,
          ledColor: AppColors.whiteColor,
        ),
      ],
    );
  }
}
