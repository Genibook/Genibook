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
    _controller.repeat(period: const Duration(seconds: 4));
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
        child: Column(
          children: [
            RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: Center(
                  child: Image(
                      image: context.isDarkMode
                          ? const AssetImage(
                              "assets/icon-blue-transparent-meow.png")
                          : const AssetImage(
                              "assets/icon-black-transparent-meow.png")),
                )),
            Text(
              "Welcome to ${Constants.appName}.",
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            Text(
              Constants.tagline,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
