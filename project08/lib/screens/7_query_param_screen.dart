import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project08/layout/default_layout.dart';

class QueryParamScreen extends StatelessWidget {
  const QueryParamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: ListView(
      children: [
        Text("Query Param : ${GoRouterState.of(context).uri.queryParameters}"),
        ElevatedButton(
            onPressed: () {
              context.push(Uri(path: '/query_param', queryParameters: {
                'name': 'yaong',
                'id': '123',
              }).toString());
            },
            child: Text("Query Param")),
      ],
    ));
  }
}
