import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/routes/navigator.dart';
import 'package:genibook/services/backgroundtasks.dart';
import 'package:genibook/cache/objects/config.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/models/secret.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/utils/grades_utils.dart';

class GradesSettingsView extends StatefulWidget {
  const GradesSettingsView({super.key});

  @override
  State<StatefulWidget> createState() => _GradesSettingsViewState();
}

class _GradesSettingsViewState extends State<GradesSettingsView> {
  Secret secret = Secret.fromJson(emptySecretDict);
  List<dynamic> mps = [];
  String? _selectedMP;
  bool _enabled = true;
  Map<String, List<dynamic>> availableStudents = {};
  String? availableStudentKey;
  int latency = -1;

  @override
  void initState() {
    ApiHandler.getMPs(true).then((value) {
      if (!mounted) return;
      setState(() {
        mps = value;
      });
    });
    StoreObjects.readSecret().then((value) {
      if (!mounted) return;
      setState(() {
        secret = value;
        _selectedMP = secret.mp;
        availableStudentKey = secret.userSelector;
      });
    });
    ConfigCache.readBgFetchVal().then((value) {
      if (!mounted) return;
      setState(() {
        _enabled = value;
      });
    });
    ApiHandler.getAvailableStudents().then((value) {
      if (!mounted) return;
      setState(() {
        availableStudents = value;
      });
    });

    super.initState();
  }

  void _onClickEnable(bool enabled) async {
    HapticFeedback.mediumImpact();

    await ConfigCache.storeBgFetchVal(enabled);
    setBackgroundFetch(enabled);
    setState(() {
      _enabled = enabled;
    });

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Grade Settings",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Test latency: ",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        "$latency ms",
                      ),
                      IconButton(
                          onPressed: () async {
                            HapticFeedback.lightImpact();
                            int lat = await ApiHandler.getLatencyThroughLogin();
                            setState(() {
                              latency = lat;
                            });
                          },
                          icon: const Icon(Icons.refresh)),
                    ],
                  ),
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Current MP: ",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      value: _selectedMP,
                      items: mps
                          .map((mp) => DropdownMenuItem(
                              value: mp,
                              child: Text(
                                mp,
                                style: const TextStyle(fontSize: 15),
                              )))
                          .toList(),
                      onChanged: (mp) {
                        HapticFeedback.lightImpact();
                        _selectedMP = mp as String;
                        secret.mp = mp;

                        ApiHandler.getMPs(true).then(
                          (value) {
                            if (!mounted) return;
                            setState(() {
                              mps = value;
                            });
                          },
                        );
                      }),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Current Student: ",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      value: availableStudentKey,
                      items: generateAvailableStudentsDropDown(
                          availableStudents, context),
                      onChanged: (aStringNumber) {
                        HapticFeedback.lightImpact();
                        String selector = aStringNumber as String;
                        secret.userSelector = selector;
                        setState(() {
                          availableStudentKey = selector;
                        });
                      }),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Background Refresh: ",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                //fuck this is hate my life sometimes
                // idk it loks shit when not enabled
                //hopefully users enable it
                Switch(
                  value: _enabled,
                  onChanged: _onClickEnable,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                child: TextButton(
                    onPressed: () async {
                      HapticFeedback.heavyImpact();
                      if (await AwesomeNotifications().getGlobalBadgeCounter() >
                          0) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Notifications Cleared!"),
                        ));
                        AwesomeNotifications().setGlobalBadgeCounter(0);
                      }
                    },
                    child: Text("Clear notifications",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 10)))),
            SizedBox(
                child: TextButton(
              onPressed: () async {
                HapticFeedback.lightImpact();
                await StoreObjects.storeSecret(secret);
                // ignore: use_build_context_synchronously
                ApiNavigator.pushToLoadingPage(context, 1);
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Save',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
              ]),
            )),
          ],
        ),
      ],
    );
  }
}
