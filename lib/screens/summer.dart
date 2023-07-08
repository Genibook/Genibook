import 'package:flutter/material.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/routes/swipes.dart';
import 'package:genibook/screens/login.dart';

class SummerScreen extends StatefulWidget {
  const SummerScreen({super.key});

  @override
  State<SummerScreen> createState() => _SummerScreenState();
}

class _SummerScreenState extends State<SummerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("It's Summer."),
          elevation: 2,
          shadowColor: Theme.of(context).shadowColor,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  await StoreObjects.logout();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .push(SlideToRightPageRoute(child: const LoginPage()));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SafeArea(
          child: ListView.builder(
              itemCount: 6,
              itemBuilder: ((context, index) {
                if (index == 0) {
                  return Text(
                    "Time to enjoy life and relax.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  );
                } else if (index == 1) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Divider(),
                      const Text("Go to the beach! 🏖️"),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                        child: Image.asset(
                          "assets/gifs/cat_beach.gif",
                        ),
                      ),
                    ],
                  );
                } else if (index == 2) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Divider(),
                      const Text("Or hang out with a best buddy 😺"),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                        child: Image.asset(
                          "assets/gifs/cat_friend.gif",
                        ),
                      ),
                    ],
                  );
                } else if (index == 3) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Divider(),
                      const Text("Maybe even touch some grass.... 🦗"),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                        child: Image.asset(
                          "assets/gifs/cat_grass.gif",
                        ),
                      ),
                    ],
                  );
                } else if (index == 4) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Divider(),
                      const Text("And remember to always stay hydrated ;)"),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                        child: Image.asset(
                          "assets/gifs/cat_drink_water.gif",
                        ),
                      ),
                      const Divider()
                    ],
                  );
                } else if (index == 5) {
                  return Text(
                    "No seriously - stop sweating and checking your grades in the middle of this beautiful summer. 🙂",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 12, fontStyle: FontStyle.italic),
                  );
                }
                return const SizedBox.shrink();
              })),
        ));
  }
}
