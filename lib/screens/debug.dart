import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genibook/cache/login/tos.dart';

class DebugScreen extends StatefulWidget {
  const DebugScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DebugScreenState();
  }
}

class _DebugScreenState extends State<DebugScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
            Column(
              children: [
                Text(
                  "API calls",
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Caching",
                  style: Theme.of(context).textTheme.headline3,
                ),
                ElevatedButton(
                    onPressed: () async {
                      bool val = await writeTOS();
                      if (kDebugMode) {
                        print("Assigned value to: $val");
                      }
                    },
                    child: const Text("TOS"))
              ],
            )
          ]))),
    );
  }
}
