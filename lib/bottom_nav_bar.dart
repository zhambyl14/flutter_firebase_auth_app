import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/top');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/game');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/map');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/profile.png',
                height: 30,
                width: 30,
              ),
              label: 'Top',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/user.png',
                height: 30,
                width: 30,
              ),
              label: 'User',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/main.png',
                height: 30,
                width: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/set.png',
                height: 30,
                width: 30,
              ),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/map.png',
                height: 30,
                width: 30,
              ),
              label: 'Map',
            ),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            _onItemTapped(context, index);
          },
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * currentIndex / 5,
          bottom: 3,
          child: Container(
            width: MediaQuery.of(context).size.width / 5,
            height: 2,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
