import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/cache/objects/config.dart';
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
import 'package:genibook/utils/theme_utils.dart';

import 'constants.dart';
import 'screens/login.dart';
import 'utils/http_overrides.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  initPlatformState();

  List<ThemeData> themelist = await giveMeLightAndDark();
  ThemeData lightTheme = themelist[0];
  ThemeData darkTheme = themelist[1];

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

class GenibookState extends State<Genibook> with WidgetsBindingObserver {
  Future<bool>? loginOrSplash;
  Future<Secret>? alreadyLoggedIn;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        //  print("app in inactive");
        break;
      case AppLifecycleState.paused:
        if (kDebugMode) {
          print("app in paused");
        }
        ConfigCache.storeSessionBioAuth(false);
        break;
      case AppLifecycleState.detached:
        if (kDebugMode) {
          print("app in detached");
        }
        ConfigCache.storeSessionBioAuth(false);

        break;
    }
  }

  @override
  void initState() {
    NotificationService.initializeNotification();

    loginOrSplash = readTOS();
    alreadyLoggedIn = StoreObjects.readSecret();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
