import 'dart:io';

import 'package:flutter/material.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/routes/swipes.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/screens/eastereggs/credits.dart';
import 'package:genibook/screens/settings/profile_settings.dart';
import 'package:genibook/utils/base64_to_image.dart';
import 'package:genibook/routes/swipe.dart';
import 'package:genibook/utils/profile_utils.dart';
import 'package:genibook/widgets/detailed/detailed_profile.dart';
import 'package:genibook/widgets/navbar.dart';
import 'package:flutter/services.dart';

import '../models/student_class.dart';

class ProfilePage extends StatefulWidget {
  final Student student;

  const ProfilePage({super.key, required this.student});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, Map<String, double>> gpaHis;
  List<Widget> gpaHistoryList = [];

  @override
  void initState() {
    super.initState();

    gpaHis = {};

    ApiHandler.getGPAhistory(true).then((value) {
      setState(() {
        gpaHis = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      gpaHistoryList =
          generateGPAHistories(gpaHis, widget.student.grade, context);
    });
    return GestureDetector(
        onPanUpdate: (details) {
          if (Platform.isIOS) {
            swipeHandler(details, Constants.profilePageNavNumber, context);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(SlideToRightPageRoute(child: const CreditsPage()));
                },
                child: const Text('Profile'),
              ),
              elevation: 2,
              shadowColor: Theme.of(context).shadowColor,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const ProfileSettings();
                          });
                    },
                    icon: const Icon(Icons.settings)),
              ],
            ),
            bottomNavigationBar: const Navbar(
              selectedIndex: Constants.profilePageNavNumber,
              disabled: false,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Card(
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
                        ))),
                    Expanded(
                        flex: 3,
                        child: Center(
                            child: GestureDetector(
                                onLongPress: () {
                                  HapticFeedback.lightImpact();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return gimmeDetailedProfileView(
                                          widget.student);
                                    },
                                  );
                                },
                                child: Card(
                                    child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: SingleChildScrollView(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children:
                                                    generateUnDetailedProfileInfo(
                                                        widget.student,
                                                        context)))))))),
                    Expanded(
                        flex: 5,
                        child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                    height: 100,
                                    child: SingleChildScrollView(
                                        child: Column(
                                      children: gpaHistoryList,
                                    )))))),
                  ],
                ),
              ),
            )));
  }
}
