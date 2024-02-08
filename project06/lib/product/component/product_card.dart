import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/const/colors.dart';
import 'package:project06/product/model/product_model.dart';
import 'package:project06/product/model/restaurant_product_model.dart';
import 'package:project06/user/provider/basket_provider.dart';

class ProductCard extends ConsumerWidget {
  final String image;
  final String name;
  final String detail;
  final int price;
  final String id;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;

  const ProductCard(
      {super.key,
      required this.image,
      required this.name,
      required this.detail,
      required this.price,
      required this.id,
      this.onSubtract,
      this.onAdd});

  factory ProductCard.fromRestaurantProductModel(
      {required RestaurantProductModel model,
      VoidCallback? onSubtract,
      VoidCallback? onAdd}) {
    return ProductCard(
      id: model.id,
      image: model.imgUrl,
      name: model.name,
      detail: model.detail,
      price: model.price,
      onAdd: onAdd,
      onSubtract: onSubtract,
    );
  }

  factory ProductCard.fromProductModel(
      {required ProductModel model,
      VoidCallback? onSubtract,
      VoidCallback? onAdd}) {
    return ProductCard(
      id: model.id,
      image: model.imgUrl,
      name: model.name,
      detail: model.detail,
      price: model.price,
      onAdd: onAdd,
      onSubtract: onSubtract,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    return Column(
      children: [
        // child의 원소들 중 최대 높이를 따라서 다른 원소들도 그 높이만큼 차지하게 됨
        IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  image,
                  width: MediaQuery.of(context).size.width * 1 / 4,
                  height: MediaQuery.of(context).size.width * 1 / 4,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    detail,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: BODY_TEXT_COLOR,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    price.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
        if (onSubtract != null && onAdd != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _Footer(
                total: basket.firstWhere((e) => e.product.id == id).count * basket.firstWhere((e) => e.product.id == id).product.price,
                count: basket.firstWhere((e) => e.product.id == id).count,
                onAdd: onAdd!,
                onSubtract: onSubtract!),
          )
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final int total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;

  const _Footer(
      {super.key,
      required this.total,
      required this.count,
      required this.onAdd,
      required this.onSubtract});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          '$total원',
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w500,
          ),
        )),
        Row(
          children: [
            renderButton(icon: Icons.remove, onTap: onSubtract),
            const SizedBox(width: 8.0,),
            Text(
              count.toString(),
              style: TextStyle(
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8.0,),
            renderButton(icon: Icons.add, onTap: onAdd),
          ],
        )
      ],
    );
  }

  Widget renderButton({required IconData icon, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: PRIMARY_COLOR, width: 1.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
