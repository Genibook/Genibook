import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/cache/login/tos.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/models/student_class.dart';
import 'package:genibook/screens/debug/backgroundtasks.dart';
import 'package:genibook/screens/grades.dart';
import 'package:genibook/screens/welcome.dart';
import 'dart:io';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_size/window_size.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'constants.dart';
import 'screens/login.dart';
import 'utils/http_overrides.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  if (UniversalPlatform.isWindows ||
      UniversalPlatform.isLinux ||
      UniversalPlatform.isMacOS) {
    setWindowMinSize(const Size(350, 700));
    setWindowMaxSize(Size.infinite);
  } else {
    // phone!
  }

  //assert(kDebugMode == true);

  runApp(const Genibook());
}

class Genibook extends StatelessWidget {
  const Genibook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //StoreObjects.logout();

    Student student = eddie;
    bool loginOrSplash = false;
    readTOS().then((value) {
      if (value) {
        loginOrSplash = true;
      }
    });
    bool alreadyLoggedIn = false;
    StoreObjects.readSecret().then(
      (value) {
        alreadyLoggedIn = value.valid;
        if (kDebugMode) {
          print("[DEBUG main()]: already logged in?: $alreadyLoggedIn");
        }
        if (value.valid) {
          ApiHandler.getNewStudent(true).then((studentt) {
            if (kDebugMode) {
              print("[DEBUG: main()]: we got a student! $studentt");
            }
            student = studentt;
          });
        }
        // future builder to get the student?
        // maybe read the cache
        // if the alreadyLogged in is true?
      },
    );
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Grades',
          theme: ThemeData(
            colorScheme: lightColorScheme ?? Constants.defaultLightColorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? Constants.defaultDarkColorScheme,
            useMaterial3: true,
          ),
          themeMode: ThemeMode.system,
          home: Constants.debugMode
              // ? const DebugScreen()
              ? const MyApp()
              : loginOrSplash
                  ? alreadyLoggedIn
                      ? GradesPage(student: student)
                      : const LoginPage()
                  : const SplashScreen());
    });
  }
}
