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

  static final gradePageNavNumber = 1;
}
