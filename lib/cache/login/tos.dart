import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

Future<void> showPrivacyPolicyDialog(BuildContext context) async {
  String privacyPolicy =
      await rootBundle.loadString('assets/privacy_policy/privacy_policy.md');
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Privacy Policy'),
        content: Markdown(data: privacyPolicy),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
