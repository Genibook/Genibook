import 'package:flutter/material.dart';
import 'package:genibook/widgets/tos.dart';
import 'package:genibook/constants.dart';

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
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // RotationTransition(
            //     turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
            //     child: Center(
            //       child: Image(
            //           image: context.isDarkMode
            //               ? const AssetImage(
            //                   "assets/icon-blue-transparent-meow.png")
            //               : const AssetImage(
            //                   "assets/icon-black-transparent.png")),
            //     )),
            Text(
              Constants.appName,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 30),
              textAlign: TextAlign.center,
            ),

            Text(
              Constants.tagline,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),

            Opacity(
              opacity: _showButton ? _controller.value : 0.0,
              child: IconButton(
                onPressed: () async {
                  showPrivacyPolicyDialog(context);
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
