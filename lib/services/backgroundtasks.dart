import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:background_fetch/background_fetch.dart';
import 'package:genipaws/api/utils.dart';
import 'package:genipaws/services/notification_service.dart';

// [Android-only] This "Headless Task" is run when the Android app is terminated with `enableHeadless: true`
// Be sure to annotate your callback function to avoid issues in release mode on Flutter >= 3.3.0
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    if (kDebugMode) {
      print("[BackgroundFetch] Headless task timed-out: $taskId");
    }
    BackgroundFetch.finish(taskId);
    return;
  }
  if (kDebugMode) {
    print('[BackgroundFetch] Headless event received.');
  }
  // Do your work here...
  BackgroundFetch.finish(taskId);
}

bool setBackgroundFetch(enabled) {
  // setState(() {
  //   _enabled = enabled;
  // });
  if (enabled) {
    BackgroundFetch.start().then((int status) {
      if (kDebugMode) {
        print('[BackgroundFetch] start success: $status');
      }
    }).catchError((e) {
      if (kDebugMode) {
        print('[BackgroundFetch] start FAILURE: $e');
      }
    });
  } else {
    BackgroundFetch.stop().then((int status) {
      if (kDebugMode) {
        print('[BackgroundFetch] stop success: $status');
      }
    });
  }
  return enabled;
}

Future<void> initPlatformState() async {
  // Configure BackgroundFetch.
  int status = await BackgroundFetch.configure(
      BackgroundFetchConfig(
          minimumFetchInterval: 15,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: true,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.ANY), (String taskId) async {
    // <-- Event handler
    // This is the fetch-event callback.
    if (kDebugMode) {
      print("[BackgroundFetch] Event received $taskId");

      print("-------[BackgroundFetch] WE STARTING UPDATING CACHES-------");
    }
    await NotificationService.initializeNotification();
    await refreshAllData(true);

    // setState(() {
    //   _events.insert(0, DateTime.now());
    // });

    // switch (taskId) {
    //   case 'com.transistorsoft.test':
    //     if (kDebugMode) {
    //       print("Received custom task");
    //     }
    //     break;
    //   default:
    //     if (kDebugMode) {
    //       print("Default fetch task");
    //     }
    // }
    // IMPORTANT:  You must signal completion of your task or the OS can punish your app
    // for taking too long in the background.

    if (kDebugMode) {
      print("-------[BackgroundFetch] WE FINISHED UPDATING CACHES-------");
    }

    BackgroundFetch.finish(taskId);
  }, (String taskId) async {
    // <-- Task timeout handler.
    // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
    if (kDebugMode) {
      print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
    }
    BackgroundFetch.finish(taskId);
  });
  if (kDebugMode) {
    print('[BackgroundFetch] configure success: $status');
  }
  // setState(() {
  //   _status = status;
  // });
}
