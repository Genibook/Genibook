import 'package:flutter/material.dart';
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

    final bdayDay = DateTime.utc(2020, month.toInt(), day.toInt());
    final currentlyNow = DateTime.utc(2020, now.month, now.day);
    //final currentlyNow = DateTime.utc(2020, 7, 6);
    bool isBday = bdayDay.isAtSameMomentAs(currentlyNow);
    // return isBday;
    if (isBday) {
      BuildContext context = Genibook.navigatorKey.currentContext!;
      await showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Happy Birthday"),
              content: Text(
                  //TODO: model complete now we just gotta set up.
                  "The Genibook Team (eddie) wishes you a happy birthday and "),
            );
          });
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
