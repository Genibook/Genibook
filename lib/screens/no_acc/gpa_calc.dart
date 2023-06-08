import 'package:flutter/material.dart';
import 'package:genibook/screens/no_acc/no_acct_navbar.dart';

class GPACalculatorScreen extends StatefulWidget {
  const GPACalculatorScreen({super.key});

  @override
  State<GPACalculatorScreen> createState() => _GPACalculatorScreenState();
}

class _GPACalculatorScreenState extends State<GPACalculatorScreen> {
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
