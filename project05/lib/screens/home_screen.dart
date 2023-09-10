import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green.shade300,
          title: const Text(
            "Today's 툰s",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
