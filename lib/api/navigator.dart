import 'package:flutter/material.dart';
import 'package:genipaws/api/handler.dart';
import 'package:genipaws/api/rawdata.dart';

import 'package:genipaws/constants.dart';

import '../routes/swipes.dart';

import 'package:genipaws/screens/login.dart';
import 'package:genipaws/screens/profile.dart';
import 'package:genipaws/screens/grades.dart';
import 'package:genipaws/screens/schedule.dart';

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
    // TODO: MAKE SURE TO ADD SOMEWHERE THAT ONLY SUPPORTS HIGH SCHOOLERS (rn middle school thing not fixed)

    //  splash screen (nvm looks ugly)

    // TODO: credits
    // TODO: finsih grade settings page
    // TODO: bday detection :D
    // TODO: make a chart or smth
    // TODO: google calendar
    // TODO: NOTIFS
    // TODO: add something for ungraded assignments
    ApiHandler.getNewStudent(true, false).then((student) {
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
    ApiHandler.getNewStudent(true, false).then((student) {
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
