import 'package:flutter/material.dart';
import 'package:project06/common/const/colors.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/restaurant/model/restaurant_detail_model.dart';
import 'package:project06/restaurant/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String name;
  final List<String> tags;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final double ratings;
  final bool isDetail;
  final String? detail;

  const RestaurantCard(
      {required this.image,
      required this.name,
      required this.tags,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.ratings,
      this.isDetail = false,
        this.detail,
      super.key});

  factory RestaurantCard.fromModel({
    required RestaurantModel restaurantModel,
    bool isDetail = false, String? detail
  }) {
    return RestaurantCard(
      image: Image.network(
        restaurantModel.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: restaurantModel.name,
      tags: restaurantModel.tags,
      ratingsCount: restaurantModel.ratingsCount,
      deliveryTime: restaurantModel.deliveryTime,
      deliveryFee: restaurantModel.deliveryFee,
      ratings: restaurantModel.ratings,
      // 상속받은 model도 넣을 수 있다
      isDetail: restaurantModel is RestaurantDetailModel ? true : false,
      detail: restaurantModel is RestaurantDetailModel ? restaurantModel.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDetail) image,
        if (!isDetail)
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: image,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16.0 : 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              tags.join(" · "),
              style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                _IconText(icon: Icons.star, label: ratings.toString()),
                _IconText(icon: Icons.receipt, label: ratingsCount.toString()),
                _IconText(
                    icon: Icons.timelapse_outlined, label: "$deliveryTime분"),
                _IconText(
                    icon: Icons.monetization_on,
                    label: "${deliveryFee == 0 ? "무료" : deliveryFee.toString()}"),
              ],
            ),
            if (detail != null && isDetail) Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(detail!),
            ),
          ]),
        )
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
      ],
    );
  }
}
