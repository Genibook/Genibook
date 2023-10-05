import 'package:flutter/material.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/api/rawdata.dart';

import 'package:genibook/constants.dart';
import 'package:genibook/screens/loading.dart';

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

  Future<void> pushToGrades<T extends Object>(
      BuildContext context, bool direction) async {
    // TODO: make a chart or smth
    // TODO: google calendar
    // TODO: add something for ungraded assignments
    ApiHandler.getNewStudent(true, false).then((student) {
      if (direction) {
        Navigator.of(context).push(SlideToLeftPageRoute(
            child:
                GradesPage(student: Constants.fakeGrades ? eddie : student)));
        return;
      }
      Navigator.of(context).push(SlideToRightPageRoute(
          child: GradesPage(student: Constants.fakeGrades ? eddie : student)));
      return;
    });
  }

  void pushToProfilePage<T extends Object>(
      BuildContext context, bool direction) {
    ApiHandler.getNewStudent(true, false).then((student) {
      if (direction) {
        Navigator.of(context).push(SlideToLeftPageRoute(
            child:
                ProfilePage(student: Constants.fakeGrades ? eddie : student)));
        return;
      }
      Navigator.of(context).push(SlideToRightPageRoute(
          child: ProfilePage(student: Constants.fakeGrades ? eddie : student)));
      return;
    });
  }

  void pushToSchedule<T extends Object>(BuildContext context, bool direction) {
    ApiHandler.getNewSchedule(true).then((schedule) {
      if (direction) {
        //means to the left
        Navigator.of(context).push(SlideToLeftPageRoute(
          child: SchedulePage(
            scheduleAssignments:
                Constants.fakeGrades ? scheduleAssignments : schedule,
          ),
        ));
        return;
      }
      Navigator.of(context).push(SlideToRightPageRoute(
        child: SchedulePage(
          scheduleAssignments:
              Constants.fakeGrades ? scheduleAssignments : schedule,
        ),
      ));
      return;
    });
  }

  static void pushToLoadingPage(BuildContext context, int from) {
    Navigator.of(context).push(
      SlideToRightPageRoute(
          child: Loading(
        fromScreen: from,
      )),
    );
    return;
  }
}
