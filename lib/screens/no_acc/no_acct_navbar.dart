import 'package:flutter/material.dart';
import 'package:genibook/routes/swipes.dart';
import 'package:genibook/screens/no_acc/game.dart';
import 'package:genibook/screens/no_acc/gpa_calc.dart';

class NoAcctNavBar extends StatelessWidget {
  const NoAcctNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            label: "GPA Calculator", icon: Icon(Icons.text_increase)),
        BottomNavigationBarItem(
          label: "Other",
          icon: Icon(Icons.rice_bowl_sharp),
        )
      ],
      onTap: (value) {
        if (value == 0) {
          Navigator.of(context)
              .push(SlideToRightPageRoute(child: const GPACalculatorScreen()));
        } else if (value == 1) {
          Navigator.of(context)
              .push(SlideToRightPageRoute(child: const GameScreen()));
        }
      },
    );
  }
}
