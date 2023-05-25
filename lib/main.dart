import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/services/backgroundtasks.dart';
import 'package:genibook/cache/login/tos.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/models/secret.dart';
import 'package:genibook/models/student_class.dart';
import 'package:genibook/screens/debug/debug.dart';
import 'package:genibook/screens/grades.dart';
import 'package:genibook/screens/welcome.dart';
import 'package:genibook/services/notification_service.dart';
import 'dart:io';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:json_theme/json_theme.dart';

import 'constants.dart';
import 'screens/login.dart';
import 'utils/http_overrides.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  initPlatformState();

  final lightThemeStr = await rootBundle.loadString('assets/light_theme.json');
  final themeJson = jsonDecode(lightThemeStr);
  final lightTheme = ThemeDecoder.decodeThemeData(themeJson)!;

  final darkThemeStr = await rootBundle.loadString('assets/dark_theme.json');
  final darkThemeJson = jsonDecode(darkThemeStr);
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;

  runApp(Genibook(
    lightTheme: lightTheme,
    darkTheme: darkTheme,
  ));
}

class Genibook extends StatefulWidget {
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  const Genibook(
      {super.key, required this.lightTheme, required this.darkTheme});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<StatefulWidget> createState() => GenibookState();
}

class GenibookState extends State<Genibook> {
  Future<bool>? loginOrSplash;
  Future<Secret>? alreadyLoggedIn;

  @override
  void initState() {
    NotificationService.initializeNotification();

    loginOrSplash = readTOS();
    alreadyLoggedIn = StoreObjects.readSecret();
    super.initState();
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
                Future<Student> student = ApiHandler.getNewStudent(true, false);

                return FutureBuilder<Student>(
                  future: student,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DynamicColorBuilder(
                          builder: (lightColorScheme, darkColorScheme) {
                        bool islightColorSchemeNull = lightColorScheme == null;
                        bool isdarkColorSchemeNull = darkColorScheme == null;

                        return MaterialApp(
                            debugShowCheckedModeBanner: false,
                            navigatorKey: Genibook.navigatorKey,
                            title: 'Grades',
                            theme: islightColorSchemeNull
                                ? widget.lightTheme
                                : ThemeData(
                                    colorScheme: lightColorScheme,
                                    useMaterial3: true),
                            darkTheme: isdarkColorSchemeNull
                                ? widget.darkTheme
                                : ThemeData(
                                    colorScheme: darkColorScheme,
                                    useMaterial3: true),
                            // ),
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
