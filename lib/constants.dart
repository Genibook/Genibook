import 'package:flutter/material.dart';
import 'package:genibook/secrets.dart';

class Constants {
  Constants._();

  static String url = URL;

  static final List<String> schools = ['Montgomery High School'];

  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);
  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  static const int profilePageNavNumber = 0;
  static const int gradePageNavNumber = 1;
  static const int schedulePageNavNumber = 2;
  static const int amountOfPages = 3;

  static const int dragSensitivity = 10;

  static const int transitionDurationOfSwipeForLeft = 155;

  static const String tagline = "It's Genesis remade.";
  static const String appName = "Genibook";
  static const String lowerCaseAppName = "genibook";

  static const Color appBlue = Color(0xFF21A8F5);

  static const bool debugMode = false;
  static const bool fakeGrades = false;
  static const bool debugModePrintEVERYTHING = false;

  static const String tosReadKey = "tos_read";
  //static const String
}
