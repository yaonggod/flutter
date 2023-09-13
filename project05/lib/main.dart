import "package:flutter/material.dart";
import "package:project05/screens/home_screen.dart";
import "package:project05/services/api_service.dart";

void main() {
  ApiService().getTodaysToons();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
