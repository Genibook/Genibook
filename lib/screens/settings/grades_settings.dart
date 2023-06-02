import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/routes/navigator.dart';
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

    ApiHandler.getAvailableStudents().then((value) {
      if (!mounted) return;
      setState(() {
        availableStudents = value;
      });
    });

    super.initState();
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
                  "Current MP: ",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonHideUnderline(
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
                    ))
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
                    child: DropdownButtonHideUnderline(
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
                    ))
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
          height: 45,
          child: ElevatedButton(
            onPressed: () async {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop();
            },
            child: Text('Cancel',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.grey)),
          ),
        ),
        SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: () async {
                HapticFeedback.lightImpact();
                await StoreObjects.storeSecret(secret);
                // ignore: use_build_context_synchronously
                ApiNavigator.pushToLoadingPage(context, 1);
              },
              child: Text('Save',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge),
            )),
      ],
    );
  }
}
