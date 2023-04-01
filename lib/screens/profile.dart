import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/icons/custom_icons_icons.dart';
import 'package:genibook/utils/swipe.dart';
import 'package:genibook/widgets/navbar.dart';

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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Card'),
                                    content: Text(
                                        'Are you sure you want to delete this card?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Delete the card here
                                          Navigator.pop(context);
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
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
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceAround,
                                        //   children: [
                                        //     const Text(
                                        //       "State ID ",
                                        //       style: TextStyle(
                                        //         fontSize: 15.0,
                                        //       ),
                                        //     ),
                                        //     Text(
                                        //       '${studentData['state_id']}',
                                        //       style:
                                        //           const TextStyle(fontSize: 12.0),
                                        //       textAlign: TextAlign.center,
                                        //     )
                                        //   ],
                                        // ),
                                        // const SizedBox(height: 10.0),
                                      ],
                                    ))))),
                  ],
                ),
              ),
            )));
  }
}
