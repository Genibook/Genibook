import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/cache/backgroundtasks.dart';
import 'package:genibook/cache/objects/config.dart';
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
  bool _enabled = true;
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
    ConfigCache.readBgFetchVal().then((value) {
      if (!mounted) return;
      setState(() {
        _enabled = value;
      });
    });
    super.initState();
  }

  void _onClickEnable(bool enabled) async {
    HapticFeedback.lightImpact();
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
              onPressed: () {
                HapticFeedback.lightImpact();
                setState(() {
                  _isLoading = true;
                });
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
