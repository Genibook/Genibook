import 'package:flutter/material.dart';

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

    // List<String> things = await readEmailPassSchoolintoCookies();
    // email = things[0];
    // password = things[1];
    // school = things[2];

    // if (index == gradesNavNum) {
    //   // ignore: use_build_context_synchronously
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => CoursesPage(
    //               email: email,
    //               password: password,
    //               school: school,
    //               refresh: false,
    //             )),
    //   );
    // } else if (index == profileNavNum) {
    //   // ignore: use_build_context_synchronously
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => StudentPage(
    //               email: email,
    //               password: password,
    //               school: school,
    //             )),
    //   );
    // } else if (index == scheduleNavNum) {
    //   // ignore: use_build_context_synchronously
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => Schedule(
    //               email: email,
    //               password: password,
    //               school: school,
    //             )),
    //   );
    // } else if (index == todoNavNum) {
    //   // ignore: use_build_context_synchronously
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
