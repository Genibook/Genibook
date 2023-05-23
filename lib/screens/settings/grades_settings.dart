import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/api/utils.dart';
import 'package:genibook/services/backgroundtasks.dart';
import 'package:genibook/cache/objects/config.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/models/secret.dart';
// import 'package:genibook/models/student_class.dart';
// import 'package:genibook/models/grades_class.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/routes/swipes.dart';
import 'package:genibook/screens/grades.dart';
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
  bool _isLoading = false;
  bool _enabled = true;
  Map<String, List<dynamic>> availableStudents = {};
  String? availableStudentKey;

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
                  "Current Student: ",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      value: availableStudentKey,
                      items:
                          generateAvailableStudentsDropDown(availableStudents),
                      onChanged: (aStringNumber) {
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
                  "Current MP: ",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      value: _selectedMP,
                      items: mps
                          .map((mp) =>
                              DropdownMenuItem(value: mp, child: Text(mp)))
                          .toList(),
                      onChanged: (mp) {
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
                  "Background Refresh: ",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
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
        SizedBox(
            width: 100,
            child: TextButton(
              onPressed: () async {
                HapticFeedback.lightImpact();
                await StoreObjects.storeSecret(secret);
                setState(() {
                  _isLoading = true;
                });
                refreshMPStudentSchedule().then((value) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(SlideToRightPageRoute(
                      child: GradesPage(
                    student: value,
                  )));
                });
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _isLoading
                    ? const CircularProgressIndicator()
                    : Text('Save',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge),
              ]),
            )),
      ],
    );
  }
}
