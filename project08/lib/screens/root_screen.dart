import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project08/layout/default_layout.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(body: ListView(
      children: [
        ElevatedButton(onPressed: () {
          context.go("/basic");
        }, child: Text("Go Basic")),
        ElevatedButton(onPressed: () {
          context.goNamed("named_screen");
        }, child: Text("Go Named")),
        ElevatedButton(onPressed: () {
          context.goNamed("push_screen");
        }, child: Text("Go Push")),
        ElevatedButton(onPressed: () {
          context.goNamed("pop_screen");
        }, child: Text("Go Pop")),
        ElevatedButton(onPressed: () {
          context.go("/path_param/123");
        }, child: Text("Go Path Param")),
        ElevatedButton(onPressed: () {
          context.go("/query_param");
        }, child: Text("Go Query Param")),
        ElevatedButton(onPressed: () {
          context.go("/nested/a");
        }, child: Text("Go Nested")),
        ElevatedButton(onPressed: () {
          context.go("/login");
        }, child: Text("Go Login")),
        ElevatedButton(onPressed: () {
          context.go("/login2");
        }, child: Text("Go Login2")),
        ElevatedButton(onPressed: () {
          context.go("/transition");
        }, child: Text("Go Transition")),
        ElevatedButton(onPressed: () {
          context.go("/e");
        }, child: Text("Error")),
      ],
    ));
  }
}
