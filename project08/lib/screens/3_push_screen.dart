import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project08/layout/default_layout.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(body: ListView(
      children: [
        // push : 현재 위치에서 새로운 라우트 스택을 쌓아서 보여줌
        // route -> push -> basic 따라서 basic에서 뒤로가면 push로 감
        ElevatedButton(onPressed: () {
          context.push("/basic");
        }, child: Text("push basic")),
        // go : 실제 router에 중첩된 상태대로 보여줌
        // route_screen -> basic_screen 따라서 basic에서 뒤로가면 route로 감
        ElevatedButton(onPressed: () {
          context.go('/basic');
        }, child: Text("go basic")),
      ],
    ));
  }
}
