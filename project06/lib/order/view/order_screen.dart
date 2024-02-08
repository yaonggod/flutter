import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/component/pagination_list_view.dart';
import 'package:project06/order/component/order_card.dart';
import 'package:project06/order/provider/order_provider.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView(provider: orderProvider, itemBuilder: <OrderModel>(_, index, model) {
      return OrderCard.fromModel(model: model);
    },);
  }
}
