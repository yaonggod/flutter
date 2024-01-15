import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project07/riverpod/provider_observer.dart';
import 'package:project07/screen/home_screen.dart';

void main() {
  runApp(
      // 상태관리로 전체 앱을 관리할거다
      ProviderScope(
          observers: [
            // 하위의 모든 provider들을 관찰
            Logger(),
          ],
          child: MaterialApp(
            home: HomeScreen(),
          )));
}
