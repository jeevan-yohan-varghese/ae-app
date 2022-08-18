
import 'package:ae_task_app/presentation/events/all_events.dart';
import 'package:ae_task_app/presentation/events/my_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomNavState();
  }
}

class _BottomNavState extends State<BottomNavScreen> {
  int selectedIndex = 0;
  final List<Widget> _fragments = <Widget>[
    AllEventsPage(),
    MyEventsPage(),
    AllEventsPage(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
            body: Center(
              child: _fragments[selectedIndex],
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 5,
              currentIndex: selectedIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: const Color(0xff808080),
              backgroundColor: const Color(0xfff3f3f4),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), label: "Events"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.connect_without_contact),
                    label: "My Events"),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                // BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
                // BottomNavigationBarItem(
                //     icon: Icon(Icons.emoji_emotions), label: "Profile"),
              ],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            )));
  }
}
