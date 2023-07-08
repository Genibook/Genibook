import 'dart:math';

import 'package:flutter/material.dart';
import 'package:genibook/routes/navigator.dart';
import 'package:genibook/api/utils.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/routes/swipes.dart';
import 'package:genibook/screens/grades.dart';
import 'package:genibook/screens/summer.dart';
import 'package:genibook/utils/dates.dart';
import 'package:genibook/widgets/navbar.dart';

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

    if (isTodaySummer()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context)
            .push(SlideToRightPageRoute(child: const SummerScreen()));
      });
    } else if (fromScreen == "login") {
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
      appBar: AppBar(
        title: const Text('Grades'),
        elevation: 2,
        shadowColor: Theme.of(context).shadowColor,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const Navbar(
        selectedIndex: Constants.gradePageNavNumber,
        disabled: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Loading...",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 13),
            ),
            const SizedBox(
              height: 15,
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
                  ?.copyWith(fontSize: 13),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              textList[currentIndex],
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 15),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )),
    );
  }
}
