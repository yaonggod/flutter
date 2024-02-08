import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/product/model/product_model.dart';
import 'package:project06/user/model/basket_item_model.dart';
import 'package:collection/collection.dart';
import 'package:project06/user/model/patch_basket_body.dart';
import 'package:project06/user/provider/user_me_repository_provider.dart';
import 'package:project06/user/repository/user_me_repository.dart';

final basketProvider =
    StateNotifierProvider<BasketProvider, List<BasketItemModel>>((ref) {
  return BasketProvider(repository: ref.watch(userMeRepositoryProvider));
});

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;

  // 여러번 실행된 함수를 1초동안 무시하다가 마지막에만 요청을 전송
  final updateBasketDebounce = Debouncer(Duration(seconds: 1), initialValue: null, checkEquality: false);

  BasketProvider({required this.repository}) : super([]) {
    updateBasketDebounce.values.listen((event) {
      patchBasket();
    });
  }

  Future<void> patchBasket() async {
    await repository.patchBasket(
        body: PatchBasketBody(
            basket: state
                .map(
                  (e) => PatchBasketBodyBasket(
                      productId: e.product.id, count: e.count),
                )
                .toList()));
  }

  // 장바구니에 넣기
  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;
    // 상품 0개 == 아직 없음
    if (!exists) {
      state = [...state, BasketItemModel(product: product, count: 1)];
    }
    // 상품 n개 -> n + 1개
    else {
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count + 1) : e)
          .toList();
    }

    // Optimistic Response
    // 응답이 성공할거라고 가정하고 상태를 먼저 업데이트
    // await patchBasket();
    updateBasketDebounce.setValue(null);
  }

  // 삭제
  Future<void> removeFromBasket(
      {required ProductModel product, bool isDelete = false}) async {
    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (exists) {
      final targetProduct = state.firstWhere((e) => e.product.id == product.id);
      // 상품 1개 -> 아예 없애버리기
      // 아니면 상품 자체를 삭제하라고 명 받았거나
      if (targetProduct.count == 1 || isDelete) {
        state = state
            .where(
              (e) => e.product.id != product.id,
            )
            .toList();
      }
      // 상품 n개 -> n - 1개
      else {
        state = state
            .map(
              (e) => e.product.id == product.id
                  ? e.copyWith(count: e.count - 1)
                  : e,
            )
            .toList();
      }

      // await patchBasket();
      updateBasketDebounce.setValue(null);
    }

    return;
  }

  void resetBasket() {
    state = [];
  }
}
