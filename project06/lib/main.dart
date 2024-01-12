import 'package:flutter/material.dart';
import 'package:project06/common/component/custom_text_form_field.dart';
import 'package:project06/common/view/root_tab.dart';
import 'package:project06/common/view/splash_screen.dart';
import 'package:project06/restaurant/view/restaurant_screen.dart';
import 'package:project06/user/view/login_screen.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
