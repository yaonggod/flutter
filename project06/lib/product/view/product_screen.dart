import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project06/common/component/pagination_list_view.dart';
import 'package:project06/product/component/product_card.dart';
import 'package:project06/product/model/product_model.dart';
import 'package:project06/product/provider/product_provider.dart';
import 'package:project06/restaurant/view/restaurant_detail_screen.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
            onTap: () {
              context.goNamed(RestaurantDetailScreen.routeName, pathParameters: {'rid': model.restaurant.id});
            }, child: ProductCard.fromProductModel(model: model));
      },
    );
  }
}
