import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/navigator/swipes.dart';
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

  bool _showButton = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );

    _controller.repeat(period: const Duration(seconds: 2));
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showButton = true;
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
            ),
            const SizedBox(
              height: 16,
            ),
            Opacity(
              opacity: _showButton ? _controller.value : 0.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      //TODO: tos page etc
                      .push(SlideToRightPageRoute(child: LoginPage()));
                },
                child: const SizedBox(
                    height: 30,
                    width: 120,
                    child: Center(
                      child: Text(
                        "Let's hop in 🐈🎓",
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
