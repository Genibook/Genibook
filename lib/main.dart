import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:local_auth/local_auth.dart';

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

class GenibookState extends State<Genibook> {
  Future<bool>? loginOrSplash;
  Future<Secret>? alreadyLoggedIn;

  late final LocalAuthentication auth;
  bool _supportState = false;
  bool doesUserUseBioAuth = false;
  bool isauth = false;

  @override
  void initState() {
    NotificationService.initializeNotification();

    loginOrSplash = readTOS();
    alreadyLoggedIn = StoreObjects.readSecret();

    ConfigCache.readBioAuth().then((bool value) {
      setState(() {
        doesUserUseBioAuth = value;
      });
    });

    super.initState();

    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) {
      setState(() {
        _supportState = isSupported;
      });
    });
  }

  Future<void> _auth() async {
    if (_supportState) {
      if (doesUserUseBioAuth) {
        try {
          bool authenticated = await auth.authenticate(
              localizedReason: "Authenticate to view grades",
              options: const AuthenticationOptions(
                  stickyAuth: true, biometricOnly: true));

          setState(() {
            isauth = authenticated;
          });
        } on PlatformException catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_supportState) {
      if (doesUserUseBioAuth) {
        if (!isauth) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  body: SafeArea(
                      child: Center(
                          child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Authenticate with biometrics",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(color: Colors.blue),
                                      textAlign: TextAlign.center,
                                    ),
                                    IconButton(
                                        iconSize: 50,
                                        onPressed: () {
                                          _auth();
                                        },
                                        icon: const Icon(Icons.login))
                                  ]))))),
              theme: widget.lightTheme,
              darkTheme: widget.darkTheme);
        }
      }
    }

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
                                : alreadyLoggedInFuture.data!.valid
                                    ? GradesPage(student: snapshot.data!)
                                    : loginOrSplashFuture.data!
                                        ? const LoginPage()
                                        : const SplashScreen());

                        // : loginOrSplashFuture.data!
                        //     ? alreadyLoggedInFuture.data!.valid
                        //         ? GradesPage(student: snapshot.data!)
                        //         : const LoginPage()
                        //     : const SplashScreen());
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
