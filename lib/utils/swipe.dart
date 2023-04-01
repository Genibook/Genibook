import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';

void swipeHandler(DragUpdateDetails details, int pageNumber) {
  if (details.delta.dx > Constants.dragSensitivity) {
    print("right");
  }

  // Swiping in left direction.
  if (details.delta.dx < -Constants.dragSensitivity) {
    print("left");
  }
}
