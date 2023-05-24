import 'package:flutter/material.dart';
import 'package:genipaws/api/handler.dart';
import 'package:genipaws/services/backgroundtasks.dart';
import 'package:genipaws/cache/login/tos.dart';
import 'package:genipaws/cache/objects/objects.dart';
import 'package:genipaws/models/secret.dart';
import 'package:genipaws/models/student_class.dart';
import 'package:genipaws/screens/debug/debug.dart';
import 'package:genipaws/screens/grades.dart';
import 'package:genipaws/screens/welcome.dart';
import 'package:genipaws/services/notification_service.dart';
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

  initPlatformState();

  //assert(kDebugMode == true);

  runApp(const Genipaws());
}

class Genipaws extends StatefulWidget {
  const Genipaws({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<StatefulWidget> createState() => GenipawsState();
}

class GenipawsState extends State<Genipaws> {
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
                        return MaterialApp(
                            debugShowCheckedModeBanner: false,
                            navigatorKey: Genipaws.navigatorKey,
                            title: 'Grades',
                            theme: ThemeData(
                              colorScheme: lightColorScheme ??
                                  Constants.defaultLightColorScheme,
                              useMaterial3: true,
                              cardTheme: CardTheme(
                                  color: lightColorScheme?.background ??
                                      Constants
                                          .defaultLightColorScheme.background
                                          .withOpacity(0.9)),
                              appBarTheme: AppBarTheme(
                                  backgroundColor:
                                      lightColorScheme?.background ??
                                          Constants.defaultLightColorScheme
                                              .background),
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
