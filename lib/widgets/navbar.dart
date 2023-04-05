import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/navigator/api_navigator.dart';

class Navbar extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Navbar({Key? key, required this.selectedIndex});
  final int selectedIndex;
  @override
  State<StatefulWidget> createState() => NavBarState();
}

class NavBarState extends State<Navbar> {
  late int _selectedIndex;
  @override
  void initState() {
    // readBday().then((value) {
    //   setState(() {
    //     _isbday = value;
    //   });
    // });
    super.initState();
    setState(() {
      _selectedIndex = widget.selectedIndex;
    });
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == Constants.gradePageNavNumber) {
      // ignore: use_build_context_synchronously

    } else if (index == Constants.profilePageNavNumber) {
      ApiNavigator nav = const ApiNavigator();
      nav.pushToLogin(context);
      // ignore: use_build_context_synchronously
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => StudentPage(
      //             email: email,
      //             password: password,
      //             school: school,
      //           )),
      // );
    } else if (index == Constants.schedulePageNavNumber) {
      // ignore: use_build_context_synchronously
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => Schedule(
      //             email: email,
      //             password: password,
      //             school: school,
      //           )),
      // );
    }
    // ignore: use_build_context_synchronously
    //   Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => const TodoList()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_increase),
          label: 'Grades',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'Schedule',
        ),
      ],
      currentIndex: _selectedIndex,
      // backgroundColor: _isbday ? Colors.amber[700] : null,
      // selectedItemColor: _isbday ? Colors.white : primaryColorColor,
      onTap: _onItemTapped,
    );
  }
}
