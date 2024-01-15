import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project07/layout/default_layout.dart';
import 'package:project07/riverpod/state_provider.dart';

// StateProvider 사용하기 위해 ConsumerWidget 사용, 접근하기 위해 WidgetRef도 받기
class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // provider에 변경이 있으면 build를 실행하기
    // numberProvider를 보고있는 위젯에서 상태 공유
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
        title: "StateProviderScreen",
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(provider.toString()),
              ElevatedButton(onPressed: () {
                // 현재 상태 state를 state + 1로 업데이트 -> 이게 numberProvider에 저장됨
                ref.read(numberProvider.notifier).update((state) => state + 1);
              }, child: Text("UP")),
              ElevatedButton(onPressed: () {
                // state를 직접 바꾸는것도 가능
                ref.read(numberProvider.notifier).state = ref.read(numberProvider.notifier).state - 1;
              }, child: Text("DOWN")),
              ElevatedButton(onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => _NextScreen())
                );
              }, child: Text("NextScreen"))
            ],
          ),
        ));
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // provider에 변경이 있으면 build를 실행하기
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
        title: "NextScreen",
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(provider.toString()),
              ElevatedButton(onPressed: () {
                // 현재 상태 state를 state + 1로 업데이트 -> 이게 numberProvider에 저장됨
                ref.read(numberProvider.notifier).update((state) => state + 1);
              }, child: Text("UP")),
              ElevatedButton(onPressed: () {
                // state를 직접 바꾸는것도 가능
                ref.read(numberProvider.notifier).state = ref.read(numberProvider.notifier).state - 1;
              }, child: Text("DOWN")),
            ],
          ),
        ));
  }
}