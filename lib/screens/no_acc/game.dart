import 'package:flutter/material.dart';
import 'package:genibook/screens/no_acc/no_acct_navbar.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("No Account?")),
        bottomNavigationBar: const NoAcctNavBar(),
        body: const SafeArea(
            child: Center(
                child: Column(
          children: [Text("HIIII")],
        ))));
  }
}
