import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku_solver/misc/router.dart';

class NavBarShell extends StatelessWidget {
  NavBarShell({required this.child, super.key});

  final Widget child;

  final List<String> _routes = [
    const HomeRoute().location,
    const BoardRoute().location,
  ];

  int getCurrentIndex(BuildContext context) {
    for (int i = 0; i < _routes.length + 1; i++) {
      if (GoRouter.of(context).location.endsWith(_routes[i])) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = getCurrentIndex(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Board',
          )
        ],
        currentIndex: selectedIndex,
        onTap: (int index) {
          context.go(_routes[index]);
        },
      ),
      body: child,
    );
  }
}
