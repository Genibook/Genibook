import 'package:flutter/material.dart';
import 'package:genibook/cache/objects/config.dart';
import 'package:genibook/main.dart';

class AppDateManager {
  static bool isTodaySummer() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    DateTime summerStart = DateTime(now.year, 7, 1);
    DateTime summerEnd = DateTime(now.year, 8, 20);
    return date.isAfter(summerStart) && date.isBefore(summerEnd);
  }

  static void seeIfTodayBirthday(String bday) async {
    //"month/day/year"

    final now = DateTime.now();
    late double month;
    late double day;

    List<String> bdays = bday.split("/");
    try {
      month = double.parse(bdays[1]);
    } catch (e) {
      month = double.parse(bdays[1][1]);
    }
    try {
      day = double.parse(bdays[0]);
    } catch (e) {
      day = double.parse(bdays[0][1]);
    }

    final bdayDay = DateTime.utc(now.year, month.toInt(), day.toInt());
    final currentlyNow = DateTime.utc(now.year, now.month, now.day);
    // final currentlyNow = DateTime.utc(now.year, 7, 6);
    bool isBday = bdayDay.isAtSameMomentAs(currentlyNow);

    // return isBday;
    if (isBday && !await ConfigCache.readBdaySeen()) {
      BuildContext context = Genibook.navigatorKey.currentContext!;
      // ignore: use_build_context_synchronously
      await showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Happy Birthday - Easter Egg 2"),
              content: Text("The Genibook team wishes you a happy birthday 🎂"),
            );
          });
      await ConfigCache.storeBdaySeen(true);
    } else if (isBday) {
    } else {
      await ConfigCache.storeBdaySeen(false);
    }
  }

  static bool checkIfValidBday(String bday) {
    if (bday.contains("/")) {
      return true;
    } else {
      return false;
    }
  }
}
