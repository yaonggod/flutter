import 'package:json_annotation/json_annotation.dart';
import 'package:project06/common/utils/data_utils.dart';
import 'package:project06/product/model/restaurant_product_model.dart';
import 'package:project06/restaurant/model/restaurant_model.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel(
      {required super.id,
      required super.name,
      required super.thumbUrl,
      required super.tags,
      required super.priceRange,
      required super.ratings,
      required super.ratingsCount,
      required super.deliveryTime,
      required super.deliveryFee,
      required this.detail,
      required this.products});

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) => _$RestaurantDetailModelFromJson(json);

  // factory RestaurantDetailModel.fromJson({required Map<String, dynamic> json}) {
  //   return RestaurantDetailModel(
  //       id: json['id'],
  //       name: json['name'],
  //       thumbUrl: "http://$ip${json['thumbUrl']}",
  //       tags: List<String>.from(json['tags']),
  //       priceRange: RestaurantPriceRange.values
  //           .firstWhere((e) => e.name == json['priceRange']),
  //       ratings: json['ratings'],
  //       ratingsCount: json['ratingsCount'],
  //       deliveryTime: json['deliveryTime'],
  //       deliveryFee: json['deliveryFee'],
  //       detail: json['detail'],
  //       products: json['products'].map<ProductModel>((x) => ProductModel.fromJson(json: x)).toList(),
  //   );
  // }
}
