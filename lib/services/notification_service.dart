import 'dart:io';

import 'package:genibook/constants.dart';
import 'package:genibook/main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  ///
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = Genibook.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              'Get Notified!',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Allow ${Constants.appName} to send you ✨beautiful✨ notifications",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text(
                        'Deny',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.grey),
                      )),
                  TextButton(
                      onPressed: () async {
                        userAuthorized = true;
                        Navigator.of(ctx).pop();
                      },
                      child: Text(
                        'Allow',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.blue),
                      )),
                ],
              ),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> checkAllowedNotif() async {
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await displayNotificationRationale();
        }
      },
    );
  }

  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_notification_app_icon', //'asset://assets/images/balloons-in-sky.jpg',
      [
        NotificationChannel(
            channelGroupKey: '${Constants.lowerCaseAppName}_grade_change',
            channelKey: '${Constants.lowerCaseAppName}_grade_change',
            channelName: 'Grade Change',
            channelDescription:
                'Notification channel for ${Constants.lowerCaseAppName} grade changes',
            defaultColor: Colors.blue,
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            soundSource: "resource://raw/res_custom_notification")
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: '${Constants.lowerCaseAppName}_grade_change_group',
          channelGroupName: 'Group 1',
        )
      ],
      debug: true,
    );

    // await AwesomeNotifications().isNotificationAllowed().then(
    //   (isAllowed) async {
    //     if (!isAllowed) {
    //       await displayNotificationRationale();
    //     }
    //   },
    // );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');

    if (receivedAction.channelKey ==
            "${Constants.lowerCaseAppName}_grade_change" &&
        Platform.isIOS) {
      AwesomeNotifications().decrementGlobalBadgeCounter();
    }
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.channelKey ==
            "${Constants.lowerCaseAppName}_grade_change" &&
        Platform.isIOS) {
      AwesomeNotifications().decrementGlobalBadgeCounter();
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
    final String? largeIcon, //'asset://assets/images/balloons-in-sky.jpg',
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: '${Constants.lowerCaseAppName}_grade_change',
        title: title,
        body: body,
        largeIcon: largeIcon,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }

  // static
}
