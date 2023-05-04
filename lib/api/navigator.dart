import 'package:flutter/material.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/api/rawdata.dart';

import 'package:genibook/constants.dart';

import '../routes/swipes.dart';

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
    // TODO: Check the assginemnts api thing cuz its returning goofy stuff cuz like its supposed to not be MP2 ....
    // TODO: integrate gpas stuff
    // TODO: make ui look nicer
    // TODO: MAKE SURE TO ADD SOMEWHERE THAT ONLY SUPPORTS HIGH SCHOOLERS

    //  splash screen (nvm looks ugly)

    // TODO: credits
    // TODO: finsih grade settings page
    // TODO: bday detection :D
    // TODO: make a chart or smth
    // TODO: google calendar
    // TODO: NOTIFS
    // TODO: add something for ungraded assignments
    // TODO: CHANGE THE WEBSITE THAT ASSIGNMENTS AND GRADED API GOES TO CUZ THERES NO Notgraded THING IN GRADE CELL
    //TODO: do like a routine so thtat every ten minutes update
    ApiHandler.getNewStudent(true).then((student) {
      if (direction) {
        Navigator.of(context).push(SlideToLeftPageRoute(
            child: GradesPage(student: Constants.debugMode ? eddie : student)));
        return;
      }
      Navigator.of(context).push(SlideToRightPageRoute(
          child: GradesPage(student: Constants.debugMode ? eddie : student)));
      return;
    });
  }

  void pushToProfilePage<T extends Object>(
      BuildContext context, bool direction) {
    ApiHandler.getNewStudent(true).then((student) {
      if (direction) {
        Navigator.of(context).push(SlideToLeftPageRoute(
            child:
                ProfilePage(student: Constants.debugMode ? eddie : student)));
        return;
      }
      Navigator.of(context).push(SlideToRightPageRoute(
          child: ProfilePage(student: Constants.debugMode ? eddie : student)));
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
                Constants.debugMode ? scheduleAssignments : schedule,
          ),
        ));
        return;
      }
      Navigator.of(context).push(SlideToRightPageRoute(
        child: SchedulePage(
          scheduleAssignments:
              Constants.debugMode ? scheduleAssignments : schedule,
        ),
      ));
      return;
    });
  }
}
