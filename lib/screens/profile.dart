import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/icons/custom_icons_icons.dart';
import 'package:genibook/utils/swipe.dart';
import 'package:genibook/widgets/navbar.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: non_constant_identifier_names
Future<void> LaunchUrl(String urll) async {
  final Uri url = Uri.parse(urll);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const ProfilePage({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerMove: (moveEvent) {
          swipeHandler(moveEvent, Constants.profilePageNavNumber);
        },
        child: Scaffold(
            bottomNavigationBar:
                const Navbar(selectedIndex: Constants.profilePageNavNumber),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(studentData['img_url']),
                              radius: 50.0,
                            ),
                          ),
                          Text(
                            studentData['name'],
                            style: const TextStyle(
                              fontSize: 27.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )),
                    Center(
                        child: GestureDetector(
                            onLongPress: () {
                              HapticFeedback.lightImpact();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: SizedBox(
                                        height: 70,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'State ID: ${studentData['state_id']}',
                                                style: const TextStyle(
                                                    fontSize: 12.0),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Birthday: ${studentData['birthday']}',
                                                style: const TextStyle(
                                                    fontSize: 12.0),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Schedule Link: ',
                                                    style: TextStyle(
                                                        fontSize: 12.0),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        LaunchUrl(studentData[
                                                            "schedule_link"]);
                                                      },
                                                      child: const Text(
                                                        "click me!",
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.blue),
                                                      ))
                                                ],
                                              ),
                                            ])),
                                  );
                                },
                              );
                            },
                            child: Card(
                                child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              "Locker ",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              '${studentData['locker']}',
                                              style: const TextStyle(
                                                  fontSize: 12.0),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              "Grade ",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              '${studentData['grade']}',
                                              style: const TextStyle(
                                                  fontSize: 12.0),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              "Counselor Name ",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              '${studentData['counselor_name']}',
                                              style: const TextStyle(
                                                  fontSize: 12.0),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                      ],
                                    ))))),
                  ],
                ),
              ),
            )));
  }
}
