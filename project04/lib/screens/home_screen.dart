import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  late Timer timer;
  bool isRunning = false;

  void onTick(Timer timer) {
    setState(() {
      totalSeconds--;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text('$totalSeconds',
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 90,
                      fontWeight: FontWeight.w600,
                    )),
              )),
          Flexible(
              flex: 3,
              child: Center(
                child: IconButton(
                  icon: !isRunning
                      ? const Icon(Icons.play_circle_outlined)
                      : const Icon(Icons.pause_circle_outline),
                  onPressed: onStartPressed,
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                ),
              )),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pomodoros',
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 60,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
