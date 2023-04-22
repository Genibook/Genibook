import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:genibook/cache/login/tos.dart';
import 'package:genibook/api/swipes.dart';
import 'package:genibook/screens/login.dart';

Future<void> showPrivacyPolicyDialog(BuildContext context) async {
  String privacyPolicy = await rootBundle.loadString('assets/pp.md');
  showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 3 / 2,
            width: MediaQuery.of(context).size.height * 3 / 2,
            child: Markdown(data: privacyPolicy),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('I agree'),
              onPressed: () async {
                if (await writeTOS()) {
                  Navigator.of(context)
                      .push(SlideToRightPageRoute(child: const LoginPage()));
                }
              },
            ),
          ],
        );
      }));
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return AlertDialog(
  //       title: const Text('Privacy Policy'),
  //       content: Markdown(data: privacyPolicy),
  //       actions: <Widget>[
  //         ElevatedButton(
  //           child: const Text('OK'),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //       ],
  //     );
  //   },
  // );
}
