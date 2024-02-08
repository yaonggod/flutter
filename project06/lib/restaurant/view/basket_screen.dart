import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:project06/common/const/colors.dart';
import 'package:project06/common/layout/default_layout.dart';
import 'package:project06/common/view/root_tab.dart';
import 'package:project06/order/provider/order_provider.dart';
import 'package:project06/product/component/product_card.dart';
import 'package:project06/restaurant/view/order_result_screen.dart';
import 'package:project06/user/provider/basket_provider.dart';

class BasketScreen extends ConsumerWidget {
  static String get routeName => 'basket';

  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    final totalPrice =
        basket.fold(0, (prev, next) => prev + next.count * next.product.price);
    Map<String, int> deliveryFee = {};
    for (var b in basket) {
      deliveryFee[b.product.restaurant.id] = b.product.restaurant.deliveryFee;
    }
    final deliveryTotal =
        deliveryFee.values.fold(0, (prev, next) => prev + next);

    if (basket.isEmpty) {
      return DefaultLayout(
        title: "장바구니",
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("장바구니가 비어있습니다.", style: TextStyle(fontSize: 18, color: PRIMARY_COLOR),),
              Expanded(child: Container()),
              _Button(
                todo: "주문하러 가기",
                todoCallback: () {
                  context.goNamed(RootTab.routeName);
                },
              ),
            ],
          ),
        ),
      );
    }

    return DefaultLayout(
        title: "장바구니",
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8.0,
                  ),
                  itemBuilder: (_, index) {
                    final model = basket[index];

                    return Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.2,

                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              ref
                                  .read(basketProvider.notifier)
                                  .removeFromBasket(product: model.product, isDelete: true);
                            },
                            icon: Icons.close,
                            label: "삭제",
                            foregroundColor: PRIMARY_COLOR,
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),
                      child: ProductCard.fromProductModel(
                        model: model.product,
                        onSubtract: () {
                          ref
                              .read(basketProvider.notifier)
                              .removeFromBasket(product: model.product);
                        },
                        onAdd: () {
                          ref
                              .read(basketProvider.notifier)
                              .addToBasket(product: model.product);
                        },
                      ),
                    );
                  },
                  itemCount: basket.length,
                ),
              ),
              Text(
                "총 $totalPrice원 + 배달료 $deliveryTotal원",
                style: TextStyle(
                    color: PRIMARY_COLOR, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8.0,
              ),
              _Button(
                  todo: "추가 주문하기",
                  todoCallback: () {
                    context.goNamed(RootTab.routeName);
                  },
                  buttonColor: Colors.white,
                  borderColor: PRIMARY_COLOR,
                  textColor: PRIMARY_COLOR),
              const SizedBox(
                height: 8.0,
              ),
              _Button(
                todo: "${totalPrice + deliveryTotal}원 결제하기",
                todoCallback: () async {
                  final result = await ref.read(orderProvider.notifier).postOrder();
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("결제 성공", textAlign: TextAlign.center,)));
                    context.goNamed(OrderResultScreen.routeName);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("결제 실패", textAlign: TextAlign.center,)));
                  }
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ));
  }

  Widget _Button(
      {required String todo,
      required VoidCallback todoCallback,
      Color? buttonColor,
      Color? borderColor,
      Color? textColor}) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: todoCallback,
            child: Container(
              decoration: BoxDecoration(
                  color: buttonColor ?? PRIMARY_COLOR,
                  border: Border.all(color: borderColor ?? PRIMARY_COLOR),
                  borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                todo,
                style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
