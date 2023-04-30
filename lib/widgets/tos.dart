import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:genibook/cache/login/tos.dart';
import 'package:genibook/api/swipes.dart';
import 'package:genibook/screens/login.dart';

Future<void> showPrivacyPolicyDialog(BuildContext context) async {
  Future<String> privacyPolicy = rootBundle.loadString('assets/pp.md');
  showDialog(
      context: context,
      builder: ((context) {
        return FutureBuilder<String>(
          future: privacyPolicy,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return AlertDialog(
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 2,
                  width: MediaQuery.of(context).size.height * 3 / 2,
                  child: Markdown(data: snapshot.data!),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('I agree'),
                    onPressed: () async {
                      if (await writeTOS()) {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(
                            SlideToRightPageRoute(child: const LoginPage()));
                      }
                    },
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
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
