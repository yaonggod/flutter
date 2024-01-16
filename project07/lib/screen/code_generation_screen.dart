import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project07/layout/default_layout.dart';
import 'package:project07/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(number1: 2, number2: 3));

    // state5만 변화가 생겼는데 전체 위젯을 재빌드하는건 에바지않나 -> 모듈화하면 그만ㅇㅇ
    // -> Consumer라는 widget으로 감싸기 -> Consumer만 재빌드
    print('build');

    return DefaultLayout(
        title: "CodeGenerationScren",
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('state1 $state1'),
            state2.when(
                data: (data) => Text(data.toString()),
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => Text("loading"),),
            state3.when(
              data: (data) => Text(data.toString()),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => Text("loading"),),
            Text('state4 $state4'),
            Row(
              children: [
                // Consumer 안의 child 위젯은 재렌더링 안함
                Consumer(builder: (context, ref, child) {
                  print('build 5');
                  final state5 = ref.watch(gStateNotifierProvider);
                  return Row(
                    children: [
                      Text('state5 $state5'),
                      child!
                    ],
                  );
                }, child: Text('hello'),),
                ElevatedButton(onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).plus();
                }, child: Text("+")),
                ElevatedButton(onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).minus();
                }, child: Text("-")),
              ],
            ),
            ElevatedButton(onPressed: () {
              // 특정 provider의 state를 dispose하기
              ref.invalidate(gStateNotifierProvider);
            }, child: Text("invalidate"))
          ],
        ));
  }
}

