import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project07/layout/default_layout.dart';
import 'package:project07/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build");
    // 필요한 값만 관찰하고 빌드하거나 함수 수행함 
    // isSpicy만 watch하고 재빌드할거임
    final state = ref.watch(selectProvider.select((value) => value.isSpicy));
    // hasBougut만 listen하고 함수 실행할거임
    ref.listen(selectProvider.select((value) => value.hasBought), (previous, next) { print("구매 완료"); });

    return DefaultLayout(
        title: "SelectProviderScreen",
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(ref.read(selectProvider.select((value) => value.name))),
              // Text(state.quantity.toString()),
              ElevatedButton(onPressed: () {
                ref.read(selectProvider.notifier).toggleIsSpicy();
              }, child: Text(state ? "매움" : "안매움")),
              ElevatedButton(onPressed: () {
                ref.read(selectProvider.notifier).toggleHasBought();
              }, child: Text("구매"))
            ],
          ),
        ));
  }
}
