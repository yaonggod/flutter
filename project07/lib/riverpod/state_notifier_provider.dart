import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project07/model/shopping_item_model.dart';

// StateNotifier를 Provider로 만들기 -> 위젯에서 사용할 수 있게끔
final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>(
        (ref) => ShoppingListNotifier());

// StateNotifier - List<ShoppingItemModel>을 관리하고 이게 state가 됨
class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  // 처음에 초기화할 값
  ShoppingListNotifier()
      : super([
          ShoppingItemModel(
              name: "김치", quantity: 3, hasBought: false, isSpicy: true),
          ShoppingItemModel(
              name: "라면", quantity: 5, hasBought: false, isSpicy: true),
          ShoppingItemModel(
              name: "삼겹살", quantity: 10, hasBought: false, isSpicy: false),
          ShoppingItemModel(
              name: "수박", quantity: 6, hasBought: false, isSpicy: false),
          ShoppingItemModel(
              name: "카스테라", quantity: 1, hasBought: false, isSpicy: false)
        ]);

  void toggleHasBought({required String name}) {
    // state 리스트 안에서 이름과 똑같은 인스턴스의 구매 여부를 toggle하기
    // 새로운 리스트를 반환, state가 새로운 리스트로 대체됨 원래 그럼... 리스트 다 순회해서 바꾸는거 비효율적인데...
    state = state
        .map((e) => e.name == name
            ? ShoppingItemModel(
                name: e.name,
                quantity: e.quantity,
                hasBought: !e.hasBought,
                isSpicy: e.isSpicy)
            : e)
        .toList();
  }
}
