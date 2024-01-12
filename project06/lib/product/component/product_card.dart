import 'package:flutter/material.dart';
import 'package:project06/common/const/colors.dart';
import 'package:project06/product/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String detail;
  final int price;

  const ProductCard(
      {super.key,
      required this.image,
      required this.name,
      required this.detail,
      required this.price});

  factory ProductCard.fromModel({ required ProductModel productModel }) {
    return ProductCard(
      image: productModel.imgUrl,
      name: productModel.name,
      detail: productModel.detail,
      price: productModel.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    // child의 원소들 중 최대 높이를 따라서 다른 원소들도 그 높이만큼 차지하게 됨
    return IntrinsicHeight(
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
    );
  }
}
