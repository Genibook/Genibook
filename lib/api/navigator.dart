import 'package:flutter/material.dart';
import 'package:genibook/api/rawdata.dart';

import 'package:genibook/constants.dart';

import 'swipes.dart';

import 'package:genibook/screens/login.dart';
import 'package:genibook/screens/profile.dart';
import 'package:genibook/screens/grades.dart';
import 'package:genibook/screens/schedule.dart';

class ApiNavigator extends Navigator {
  const ApiNavigator({super.key});

  void useNumbersToDetermine(int number, BuildContext context, bool direction) {
    if (number == Constants.gradePageNavNumber) {
      pushToGrades(context, direction);
    } else if (number == Constants.profilePageNavNumber) {
      pushToProfilePage(context, direction);
    } else if (number == Constants.schedulePageNavNumber) {
      pushToSchedule(context, direction);
    }
  }

  void pushToLogin<T extends Object>(BuildContext context) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const LoginPage(),
      ),
    );
  }

  void pushToGrades<T extends Object>(BuildContext context, bool direction) {
    // get new data or smth
    // read grades cache if the cache is filled
    // compare == ( i think get students already does it, do it)

    if (Constants.debugMode) {
      if (direction) {
        //means to the left
        Navigator.of(context)
            .push(SlideToLeftPageRoute(child: GradesPage(student: eddie)));
        return;
      }
      Navigator.of(context)
          .push(SlideToRightPageRoute(child: GradesPage(student: eddie)));
      return;
    }
  }

  void pushToProfilePage<T extends Object>(
      BuildContext context, bool direction) {
    if (Constants.debugMode) {
      if (direction) {
        //means to the left
        Navigator.of(context)
            .push(SlideToLeftPageRoute(child: ProfilePage(student: eddie)));
        return;
      }
      Navigator.of(context)
          .push(SlideToRightPageRoute(child: ProfilePage(student: eddie)));
      return;
    }
  }

  void pushToSchedule<T extends Object>(BuildContext context, bool direction) {
    if (Constants.debugMode) {
      if (direction) {
        //means to the left
        Navigator.of(context).push(SlideToLeftPageRoute(
          child: SchedulePage(
            scheduleAssignments: scheduleAssignments,
          ),
        ));
        return;
      }
      Navigator.of(context).push(SlideToRightPageRoute(
        child: SchedulePage(
          scheduleAssignments: scheduleAssignments,
        ),
      ));
      return;
    }
  }
}
