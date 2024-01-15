import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project07/model/shopping_item_model.dart';
import 'package:project07/riverpod/state_notifier_provider.dart';

// read는 잘 안씀 watch하는 provider가 변경되면 최상위 provider(이거)도 변경되어야함
final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>((ref) {
  final filterState = ref.watch(filterProvider);
  final shoppingListState = ref.watch(shoppingListProvider);

  if (filterState == FilterState.notSpicy) {
    return shoppingListState.where((e) => !e.isSpicy).toList();
  }
  if (filterState == FilterState.spicy) {
    return shoppingListState.where((e) => e.isSpicy).toList();
  }
  return shoppingListState;
});

enum FilterState {
  notSpicy, spicy, all,
}

final filterProvider = StateProvider((ref) => FilterState.all);