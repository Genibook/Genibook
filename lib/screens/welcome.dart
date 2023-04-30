import 'package:flutter/material.dart';
import 'package:genibook/widgets/tos.dart';
import 'package:genibook/constants.dart';
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
  bool continuee = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _controller.forward();
    // _controller.repeat(period: const Duration(seconds: 2));
    Future.delayed(const Duration(seconds: 2), () {
      if (continuee) {
        setState(() {
          _showButton = true;
          _controller.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    continuee = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //LoginPage()
    return Scaffold(
        body: Container(
      decoration: context.isDarkMode
          ? null
          : const BoxDecoration(color: Constants.appBlue),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(5),
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
                              "assets/icon-black-transparent.png")),
                )),
            Text(
              "Welcome to ${Constants.appName}.",
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Text(
              Constants.tagline,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Opacity(
              opacity: _showButton ? _controller.value : 0.0,
              child: ElevatedButton(
                onPressed: () async {
                  showPrivacyPolicyDialog(context);
                },
                child: const SizedBox(
                    height: 50,
                    width: 120,
                    child: Center(
                      child: Text(
                        "Let's hop in 🐈🎓",
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            ),
            const Spacer(),
          ],
        ),
      )),
    ));
  }
}
