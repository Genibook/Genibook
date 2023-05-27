import 'package:json_theme/json_theme.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

Future<List<ThemeData>> giveMeLightAndDark() async {
  final lightThemeStr = await rootBundle.loadString('assets/light_theme.json');
  final themeJson = jsonDecode(lightThemeStr);
  final lightTheme = ThemeDecoder.decodeThemeData(themeJson)!;

  final darkThemeStr = await rootBundle.loadString('assets/dark_theme.json');
  final darkThemeJson = jsonDecode(darkThemeStr);
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;
  return [lightTheme, darkTheme];
}
