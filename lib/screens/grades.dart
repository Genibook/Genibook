import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/cache/objects/config.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/models/gpas.dart';
import 'package:genibook/routes/navigator.dart';
import 'package:genibook/screens/settings/grades_settings.dart';
import 'package:genibook/services/notification_service.dart';
import 'package:genibook/utils/grades_utils.dart';
import 'package:genibook/widgets/detailed/detailed_grade_info.dart';
import 'package:genibook/widgets/navbar.dart';
import 'package:local_auth/local_auth.dart';
import '../routes/swipe.dart';
import 'assignments.dart';
import '../models/student_class.dart';

class GradesPage extends StatefulWidget {
  final Student student;

  const GradesPage({super.key, required this.student});

  @override
  // ignore: library_private_types_in_public_api
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  Gpa? studentGpa;

  late final LocalAuthentication auth;
  bool _supportState = false;
  bool doesUserUseBioAuth = false;
  bool isauth = false;
  bool sessionBioAuth = true;
  @override
  void initState() {
    ApiHandler.getGpa(true).then((value) {
      setState(() {
        studentGpa = value;
      });
    });

    ConfigCache.readBioAuth().then((bool value) {
      setState(() {
        doesUserUseBioAuth = value;
      });
    });

    ConfigCache.readSessionBioAuth().then((bool value) {
      setState(() {
        sessionBioAuth = value;
      });
    });

    NotificationService.checkAllowedNotif();
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
          await ConfigCache.storeSessionBioAuth(isauth);
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
        if (!sessionBioAuth) {
          if (!isauth) {
            return SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                    "Authenticate to view grades",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  IconButton(
                      iconSize: 50,
                      onPressed: () {
                        _auth();
                      },
                      icon: const Icon(Icons.login))
                ]));
          }
        }
      }
    }
    return GestureDetector(
        onPanUpdate: (details) {
          swipeHandler(details, Constants.gradePageNavNumber, context);
        },
        child: Scaffold(
            bottomNavigationBar: const Navbar(
              selectedIndex: Constants.gradePageNavNumber,
              disabled: false,
            ),
            appBar: AppBar(
              title: const Text('Grades'),
              elevation: 2,
              shadowColor: Theme.of(context).shadowColor,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  showDetailedGradePageView(context, studentGpa);
                },
              ),
              actions: [
                SizedBox(
                    height: 50,
                    width: 50,
                    child: IconButton(
                        onPressed: (() {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return const GradesSettingsView();
                              }));
                        }),
                        icon: const Icon(Icons.settings))),
              ],
            ),
            body: SafeArea(
                child: RefreshIndicator(
              strokeWidth: 3,
              onRefresh: () async {
                ApiNavigator.pushToLoadingPage(context, 2);
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget.student.grades.length,
                itemBuilder: (BuildContext context, int index) {
                  if (kDebugMode) {
                    if (Constants.debugModePrintEVERYTHING) {
                      print(
                          "[DEBUG: Grades page build, Item builder]: ${widget.student.grades.toJson()}");

                      print(
                          "[DEBUG: Grades page build, Item builder]: $index , ${widget.student.grades.keys.elementAt(index)}");
                    }
                  }
                  String courseName =
                      widget.student.grades.keys.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssignmentPage(
                            assignmentsForAClass:
                                widget.student.assignments[courseName],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              courseName,
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Teacher: ${widget.student.grades.getSubjectTeacherName(courseName)}',
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Email: ${widget.student.grades.getSubjectTeacherEmail(courseName)}',
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Grade:',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  widget.student.grades
                                      .getSubjectGrade(courseName)
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: getColorFromGrade(widget
                                          .student.grades
                                          .getSubjectGrade(courseName))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ))));
  }
}
