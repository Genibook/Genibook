import 'package:flutter/material.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/routes/swipes.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/screens/eastereggs/credits.dart';
import 'package:genibook/utils/base64_to_image.dart';
import 'package:genibook/routes/swipe.dart';
import 'package:genibook/widgets/navbar.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/student_class.dart';

// ignore: non_constant_identifier_names
Future<void> LaunchUrl(String urll) async {
  final Uri url = Uri.parse(urll);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class ProfilePage extends StatefulWidget {
  final Student student;

  const ProfilePage({super.key, required this.student});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Map<String, Map<String, double>>>? gpaHisFuture;
  @override
  void initState() {
    super.initState();

    setState(() {
      gpaHisFuture = ApiHandler.getGPAhistory(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanUpdate: (details) {
          swipeHandler(details, Constants.profilePageNavNumber, context);
        },
        child: Scaffold(
            appBar: AppBar(
                title: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        SlideToRightPageRoute(child: const CreditsPage()));
                  },
                  child: const Text('Profile'),
                ),
                elevation: 2,
                shadowColor: Theme.of(context).shadowColor,
                automaticallyImplyLeading: false),
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
                              backgroundImage: Constants.debugMode
                                  ? NetworkImage(widget.student.imageUrl)
                                  : imageFromBase64String(
                                          widget.student.image64)
                                      .image,
                              radius: 50.0,
                            ),
                          ),
                          Text(
                            widget.student.name,
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
                                        height: 90,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Locker : ${widget.student.locker}',
                                                style: const TextStyle(
                                                    fontSize: 12.0),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'State ID: ${widget.student.stateId}',
                                                style: const TextStyle(
                                                    fontSize: 12.0),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Birthday: ${widget.student.birthday}',
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
                                                        LaunchUrl(widget.student
                                                            .scheduleLink);
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
                                              widget.student.locker,
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
                                              '${widget.student.grade}',
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
                                              widget.student.counselorName,
                                              style: const TextStyle(
                                                  fontSize: 12.0),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ],
                                    ))))),
                    Card(
                        child: SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: FutureBuilder<
                                        Map<String, Map<String, double>>>(
                                    future: gpaHisFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SingleChildScrollView(
                                            child: ListView.builder(
                                          itemBuilder: (context, index) {
                                            String year = snapshot.data!.keys
                                                .elementAt(index);

                                            return ListTile(
                                              title: Text(
                                                  "Weighted: ${snapshot.data![year]!['weighted']}"),
                                            );
                                          },
                                        ));
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    })))),
                  ],
                ),
              ),
            )));
  }
}
