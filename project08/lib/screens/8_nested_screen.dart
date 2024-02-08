import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NestedScreen extends StatelessWidget {
  final Widget child;
  const NestedScreen({ required this.child, super.key});

  int getIndex(BuildContext context) {
    if (GoRouterState.of(context).matchedLocation == "nested/a") {
      return 0;
    }
    if (GoRouterState.of(context).matchedLocation == "nested/b") {
      return 1;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${GoRouterState.of(context).matchedLocation}"),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: getIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/nested/a');
              break;
            case 1:
              context.go('/nested/b');
              break;
            case 2:
              context.go('/nested/c');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "person"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "noti"),
        ],
      ),
    );
  }
}
