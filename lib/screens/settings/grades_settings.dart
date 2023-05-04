import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/api/utils.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/models/secret.dart';
// import 'package:genibook/models/student_class.dart';
// import 'package:genibook/models/grades_class.dart';
import 'package:genibook/api/handler.dart';

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

  @override
  void initState() {
    setState(() {});
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
                  child: DropdownButton(
                      value: _selectedMP,
                      items: mps
                          .map((mp) =>
                              DropdownMenuItem(value: mp, child: Text(mp)))
                          .toList(),
                      onChanged: (mp) {
                        _selectedMP = mp as String;
                        secret.mp = mp;
                        StoreObjects.storeSecret(secret);
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
            )
          ],
        ),
      ),
      // content: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Text(
      //         assignment.category,
      //         style:
      //             const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      //       ),
      //       const SizedBox(height: 6),
      //       Text(assignment.teacher),
      //       Text(
      //           '${assignment.fullDayName} - ${assignment.fullDate} - MP ${assignment.mp}'),
      //       const SizedBox(height: 10),
      //       Text('Description: ${assignment.description}'),
      //       const SizedBox(height: 6),
      //       Text('Comment: ${assignment.comment}'),
      //       const SizedBox(height: 6),
      //       Text(
      //         'Grade: ${assignment.gradePercent} (${assignment.gradeNum})',
      //         style: const TextStyle(fontSize: 17),
      //       ),
      //     ],
      //   ),
      // ),

      actions: <Widget>[
        SizedBox(
            width: 100,
            child: TextButton(
              onPressed: () async {
                HapticFeedback.lightImpact();
                setState(() {
                  _isLoading = true;
                });
                refreshAllData();
                Navigator.of(context).pop();
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(_isLoading ? 'Loading... ' : 'Save',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
              ]),
            )),
      ],
    );
  }
}
