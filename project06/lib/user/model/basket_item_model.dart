import 'package:json_annotation/json_annotation.dart';
import 'package:project06/product/model/product_model.dart';

part 'basket_item_model.g.dart';

@JsonSerializable()
class BasketItemModel {
  final ProductModel product;
  final int count;

  BasketItemModel({ required this.product, required this.count });

  BasketItemModel copyWith({ ProductModel? productModel, int? count }) {
    return BasketItemModel(product: productModel ?? this.product, count: count ?? this.count);
  }

  factory BasketItemModel.fromJson(Map<String, dynamic> json)
  => _$BasketItemModelFromJson(json);
}