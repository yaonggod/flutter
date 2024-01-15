import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project07/layout/default_layout.dart';
import 'package:project07/riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue state = ref.watch(multipleFutureProvider);

    return DefaultLayout(
        title: "FutureProviderScreen",
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            state.when(
              // 로딩이 끝나서 데이터가 있을 때
              data: (data) {
                return Text(data.toString(), textAlign: TextAlign.center,);
              },
              // 에러가 났을 때
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              // 로딩하고 있을 때
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
            )
          ],
        ));
  }
}
