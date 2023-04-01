import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';

void swipeHandler(PointerMoveEvent moveEvent, int pageNumber) {
  if (moveEvent.delta.dx > 0) {
    print("swipe right");
  } else if (moveEvent.delta.dx < 0) {
    print("swipe left");
  }
}
