import 'package:flutter/material.dart';

class CreditsPage extends StatefulWidget {
  const CreditsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CreditsPageState();
}

class CreditsPageState extends State<CreditsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleTextStyle: Theme.of(context).textTheme.headlineLarge,
          centerTitle: true,
          title: const Text(
            "Credits 🐾",
            textAlign: TextAlign.center,
          ),
        ),
        body: const Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Center(
                    child: SizedBox(
                        height: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Users - You! \n (This is the first easter egg created for this app, yay!)",
                              textAlign: TextAlign.center,
                            ),
                            Divider(),
                            Text(
                              "Zenesus Beta Testers: Etaash, Niketh, Justin, Ayaan",
                              textAlign: TextAlign.center,
                            ),
                            Divider(),
                            Text(
                              "Genibook Beta Testers: Etaash, Niketh, Justin, Ayaan, Jason",
                              textAlign: TextAlign.center,
                            ),
                            Divider(),
                            Text(
                              "Developers - Eddie",
                              textAlign: TextAlign.center,
                            )
                          ],
                        ))))));
  }
}
