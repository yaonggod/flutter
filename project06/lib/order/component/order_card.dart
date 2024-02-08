import 'package:flutter/material.dart';
import 'package:project06/common/const/colors.dart';
import 'package:project06/order/model/order_model.dart';

class OrderCard extends StatelessWidget {
  final DateTime orderDate;
  final Image image;
  final String name;
  final String productDetail;
  final int price;

  const OrderCard(
      {super.key, required this.orderDate, required this.image, required this.name, required this.productDetail, required this.price });

  factory OrderCard.fromModel({ required OrderModel model }) {
    String productsDetail = model.products.first.product.name;
    if (model.products.length > 1) {
      productsDetail = '$productsDetail 외 ${model.products.length - 1}개';
    }
    return OrderCard(orderDate: model.createdAt,
        image: Image.network(model.restaurant.thumbUrl, height: 60.0,
            width: 60.0,
            fit: BoxFit.cover),
        name: model.restaurant.name,
        productDetail: productsDetail,
        price: model.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${orderDate.year}.${orderDate.month.toString().padLeft(
            2, '0')}.${orderDate.day.toString().padLeft(2, '0')} 주문 완료"),
        const SizedBox(height: 8.0),
        Row(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(16.0), child: image,),
            const SizedBox(width: 16.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 14.0),),
                Text('$productDetail $price원', style: TextStyle(
                    fontWeight: FontWeight.w300),),
              ],
            )
          ],
        )
      ],
    );
  }
}
