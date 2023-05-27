import 'dart:math';

import 'package:flutter/material.dart';
import 'package:genibook/routes/navigator.dart';
import 'package:genibook/api/utils.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/routes/swipes.dart';
import 'package:genibook/screens/grades.dart';

class Loading extends StatefulWidget {
  final int fromScreen;

  const Loading({super.key, required this.fromScreen});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  ApiNavigator nav = const ApiNavigator();
  Random random = Random();
  int currentIndex = -1;

  List<String> textList = [
    "Our app uses cats as comforting assistants?",
    "Genibook actually had a version 1 - called Zenesus!",
    "You can contact eddietang2314@gmail.com if you have any questions!",
    "Genibook/Zenesus's first supported opperating system was Windows.",
    "Genibook is free and open source! Link: https://github.com/Zenesus",
  ];

  void startLooping() {
    if (currentIndex == -1) {
      setState(() {
        currentIndex = random.nextInt(textList.length);
      });
    }
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        currentIndex = (currentIndex + 1) % textList.length;
      });
      startLooping();
    });
  }

  @override
  void initState() {
    super.initState();
    startLooping();
    String fromScreen =
        Constants.loadingPageFromMap[widget.fromScreen] ?? "login";

    if (fromScreen == "login") {
      refreshAllData(false).then((value) => nav.pushToGrades(context, false));
    } else if (fromScreen == "grade_settings") {
      refreshMPStudentSchedule().then((value) {
        Navigator.of(context).push(SlideToRightPageRoute(
            child: GradesPage(
          student: value,
        )));
      });
    } else if (fromScreen == "grade_refresh") {
      refreshAllData(false).then((value) => nav.pushToGrades(context, false));
    } else if (fromScreen == "debug") {
    } else {
      refreshAllData(false).then((value) => nav.pushToGrades(context, false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 40,
        child: Text(
          "Loading...",
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Image.asset(
                    "assets/loadcat.gif")), // Replace 'your_gif.gif' with your actual GIF file path
            const SizedBox(height: 20.0),
            Text(
              "Did you know that:",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              textList[currentIndex],
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 23),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
