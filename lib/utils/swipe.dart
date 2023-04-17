import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/navigator/api_navigator.dart';

void swipeHandler(
    DragUpdateDetails details, int pageNumber, BuildContext context) {
  ApiNavigator nav = const ApiNavigator();

  if (details.delta.dx > Constants.dragSensitivity) {
    print("right");
    int nextNum = pageNumber - 1;
    if (0 <= nextNum) {
      nav.useNumbersToDetermine(nextNum, context);
    }
    print(pageNumber);
    print(nextNum);
  }

  // Swiping in left direction.
  if (details.delta.dx < -Constants.dragSensitivity) {
    print("left");
    int nextNum = pageNumber + 1;
    if (nextNum <= Constants.amountOfPages) {
      nav.useNumbersToDetermine(nextNum, context);
    }
    print(pageNumber);
    print(nextNum);
  }
}
