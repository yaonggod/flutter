import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project07/layout/default_layout.dart';
import 'package:project07/riverpod/provider.dart';
import 'package:project07/riverpod/state_notifier_provider.dart';

class ProviderScreen extends ConsumerWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // shoppingListProvider의 state를 변경해도 filtered에 적용되어 build가 다시 실행됨
    final state = ref.watch(filteredShoppingListProvider);
    print(state);
    return DefaultLayout(
        title: "ProviderScreen",
        actions: [
          PopupMenuButton<FilterState>(
            itemBuilder: (_) => FilterState.values
                .map((e) => PopupMenuItem(value: e, child: Text(e.name)))
                .toList(),
            onSelected: (value) {
              ref.read(filterProvider.notifier).update((state) => value);
            },
          )
        ],
        body: ListView(
          children: state
              .map((e) => CheckboxListTile(
                    title: Text(e.name),
                    value: e.hasBought,
                    onChanged: (value) {
                      // provider의 notifier를 가져와서 메서드 실행
                      ref
                          .read(shoppingListProvider.notifier)
                          .toggleHasBought(name: e.name);
                    },
                  ))
              .toList(),
        ));
  }
}
