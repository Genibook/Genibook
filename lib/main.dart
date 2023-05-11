import 'package:flutter/material.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/cache/backgroundtasks.dart';
import 'package:genibook/cache/login/tos.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/models/secret.dart';
import 'package:genibook/models/student_class.dart';
import 'package:genibook/screens/debug/debug.dart';
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

class Genibook extends StatefulWidget {
  const Genibook({super.key});

  @override
  State<StatefulWidget> createState() => GenibookState();
}

class GenibookState extends State<Genibook> {
  Future<bool>? loginOrSplash;
  Future<Secret>? alreadyLoggedIn;

  @override
  void initState() {
    super.initState();
    loginOrSplash = readTOS();
    alreadyLoggedIn = StoreObjects.readSecret();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: loginOrSplash,
      builder: (context, loginOrSplashFuture) {
        if (loginOrSplashFuture.hasData) {
          return FutureBuilder<Secret>(
            future: alreadyLoggedIn,
            builder: (context, alreadyLoggedInFuture) {
              if (alreadyLoggedInFuture.hasData) {
                Future<Student> student = ApiHandler.getNewStudent(true);

                return FutureBuilder<Student>(
                  future: student,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DynamicColorBuilder(
                          builder: (lightColorScheme, darkColorScheme) {
                        return MaterialApp(
                            debugShowCheckedModeBanner: false,
                            title: 'Grades',
                            theme: ThemeData(
                              colorScheme: lightColorScheme ??
                                  Constants.defaultLightColorScheme,
                              useMaterial3: true,
                            ),
                            darkTheme: ThemeData(
                              colorScheme: darkColorScheme ??
                                  Constants.defaultDarkColorScheme,
                              useMaterial3: true,
                            ),
                            themeMode: ThemeMode.system,
                            home: Constants.debugMode
                                ? const DebugScreen()
                                //? const MyApp()
                                : loginOrSplashFuture.data!
                                    ? alreadyLoggedInFuture.data!.valid
                                        ? GradesPage(student: snapshot.data!)
                                        : const LoginPage()
                                    : const SplashScreen());
                      });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
