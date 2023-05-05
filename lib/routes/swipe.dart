import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/api/navigator.dart';

void swipeHandler(
    DragUpdateDetails details, int pageNumber, BuildContext context) {
  ApiNavigator nav = const ApiNavigator();

  if (details.delta.dx > Constants.dragSensitivity) {
    //print("right -> that means i want to go to the left screen");
    int nextNum = pageNumber - 1;
    if (0 <= nextNum) {
      nav.useNumbersToDetermine(nextNum, context, true);
    }
    // print(pageNumber);
    // print(nextNum);
  }

  // Swiping in left direction.
  if (details.delta.dx < -Constants.dragSensitivity) {
    //print("left");
    int nextNum = pageNumber + 1;
    if (nextNum <= Constants.amountOfPages) {
      nav.useNumbersToDetermine(nextNum, context, false);
    }
    // print(pageNumber);
    // print(nextNum);
  }
}
