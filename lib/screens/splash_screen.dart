import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/screens/login.dart';
import 'package:genibook/extensions/darkmode.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //LoginPage()
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
          child: Column(children: [
            Image(
                image: context.isDarkMode
                    ? const AssetImage("assets/icon-blue-transparent-meow.png")
                    : const AssetImage(
                        "assets/icon-black-transparent-meow.png")),
            Text(
              "Welcome to ${Constants.appName}.",
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              Constants.tagline,
              style: Theme.of(context).textTheme.headline2,
            )
          ]),
        ),
      ),
    ));
  }
}
