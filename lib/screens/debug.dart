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
              child: Row(children: [
        Column(
          children: const [Text("API calls")],
        ),
        Column(
          children: [
            const Text("Caching"),
            ElevatedButton(
                onPressed: () async {
                  bool val = await writeTOS();
                  if (kDebugMode) {
                    print(val);
                  }
                },
                child: const Text(""))
          ],
        )
      ]))),
    );
  }
}
