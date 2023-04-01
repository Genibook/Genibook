import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/widgets/navbar.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const ProfilePage({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          studentData['name'],
                          style: const TextStyle(
                            fontSize: 27.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(studentData['img_url']),
                            radius: 50.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                Center(
                    child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      color: Colors.blueAccent[400],
                                      size: 35,
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          child: const Text(
                                            "GPA history",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          onTap: () {},
                                        ),
                                        InkWell(
                                          child: const Text(
                                            "click me",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.school,
                                      color: Colors.yellowAccent[400],
                                      size: 35,
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Grade Level",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        Text(
                                          '${studentData['grade']}',
                                          style:
                                              const TextStyle(fontSize: 12.0),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.key,
                                      color: Colors.pinkAccent[400],
                                      size: 35,
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Locker",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        Text(
                                          '${studentData['locker']}',
                                          style:
                                              const TextStyle(fontSize: 12.0),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'counsler naeS ID: ${studentData['counselor_name']}',
                                  style: const TextStyle(fontSize: 18.0),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.flag,
                                      color: Colors.purple[700],
                                      size: 35,
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "State ID",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        Text(
                                          '${studentData['state_id']}',
                                          style:
                                              const TextStyle(fontSize: 12.0),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                              ],
                            )))),
              ],
            ),
          ),
        ));
  }
}
