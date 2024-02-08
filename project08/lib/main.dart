import 'package:flutter/material.dart';
import 'package:project08/route/router.dart';
import 'package:project08/screens/root_screen.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
