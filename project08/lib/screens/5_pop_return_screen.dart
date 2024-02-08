import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project08/layout/default_layout.dart';

class PopReturnScreen extends StatelessWidget {
  const PopReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(body: ListView(
      children: [
        ElevatedButton(onPressed: () {
          // 뒤로가기 + 이전 화면에 데이터 전달하기
          context.pop("codefactory");
        }, child: Text("pop")),
      ],
    ));
  }
}
