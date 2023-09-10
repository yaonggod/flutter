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
  int pomodoro = 0;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        pomodoro += 1;
        isRunning = false;
        totalSeconds = 1500;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onStartPressed() {
    setState(() {
      isRunning = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  void onPausePressed() {
    setState(() {
      isRunning = false;
    });
    timer.cancel();
  }

  void reset() {
    setState(() {
      isRunning = false;
      totalSeconds = 1500;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    var min = duration.toString().split('.')[0].split(':')[1];
    var sec = duration.toString().split('.')[0].split(':')[2];
    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(format(totalSeconds),
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 90,
                      fontWeight: FontWeight.w600,
                    )),
              )),
          Flexible(
              flex: 3,
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    IconButton(
                      icon: !isRunning
                          ? const Icon(Icons.play_circle_outlined)
                          : const Icon(Icons.pause_circle_outline),
                      onPressed: !isRunning ? onStartPressed : onPausePressed,
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                    ),
                    !isRunning
                        ? IconButton(
                            icon: const Icon(Icons.replay_outlined),
                            onPressed: reset,
                            iconSize: 120,
                            color: Theme.of(context).cardColor,
                          )
                        : Text(
                            'press pause if you want to reset the timer',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                  ]))),
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
                            '$pomodoro',
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
        ]));
  }
}
