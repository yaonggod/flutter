import 'package:json_annotation/json_annotation.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/common/utils/data_utils.dart';

// flutter pub run build_runner build -> 일회성 빌드
// flutter pub run build_runner watch -> 변화 확인 시 재빌드
part 'restaurant_model.g.dart';

enum RestaurantPriceRange { expensive, medium, cheap }

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(
    // json -> model 할 때 주소 알아서 바꿔줘
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  // json -> model
  factory RestaurantModel.fromJson(Map<String, dynamic> json) => _$RestaurantModelFromJson(json);

  // model -> json
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  // factory RestaurantModel.fromJson({ required Map<String, dynamic> json }) {
  //   return RestaurantModel(
  //       id: json['id'],
  //       name: json['name'],
  //       thumbUrl: "http://$ip${json['thumbUrl']}",
  //       tags: List<String>.from(json['tags']),
  //       priceRange: RestaurantPriceRange.values.firstWhere((e) => e.name == json['priceRange']),
  //       ratings: json['ratings'],
  //       ratingsCount: json['ratingsCount'],
  //       deliveryTime: json['deliveryTime'],
  //       deliveryFee: json['deliveryFee']);
  // }
}
