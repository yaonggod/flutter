import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/provider/pagination_provider.dart';
import 'package:project06/order/model/order_model.dart';
import 'package:project06/order/model/post_order_body.dart';
import 'package:project06/order/repository/order_repository.dart';
import 'package:project06/user/provider/basket_provider.dart';
import 'package:uuid/uuid.dart';

final orderProvider =
    StateNotifierProvider<OrderStateNotifier, CursorPaginationBase>((ref) =>
        OrderStateNotifier(
            ref: ref, repository: ref.watch(orderRepositoryProvider)));

class OrderStateNotifier extends PaginationProvider<OrderModel, OrderRepository>{
  final Ref ref;

  OrderStateNotifier({required this.ref, required super.repository});

  Future<bool> postOrder() async {
    try {
      final uuid = Uuid();
      final id = uuid.v4();
      final state = ref.read(basketProvider);

      final totalPrice =
      state.fold(0, (prev, next) => prev + next.count * next.product.price);
      Map<String, int> deliveryFee = {};
      for (var b in state) {
        deliveryFee[b.product.restaurant.id] = b.product.restaurant.deliveryFee;
      }
      final deliveryTotal =
      deliveryFee.values.fold(0, (prev, next) => prev + next);

      final resp = await repository.postOrder(
          body: PostOrderBody(
              id: id,
              products: state
                  .map((e) => PostOrderBodyProduct(
                  productId: e.product.id, count: e.count))
                  .toList(),
              totalPrice: totalPrice + deliveryTotal,
              createdAt: DateTime.now().toString()));

      return true;
    } catch (e) {
      return false;
    }

  }
}
