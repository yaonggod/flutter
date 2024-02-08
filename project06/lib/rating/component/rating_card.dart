import 'package:flutter/material.dart';
import 'package:project06/common/const/colors.dart';
import 'package:collection/collection.dart';
import 'package:project06/rating/model/rating_model.dart';

class RatingCard extends StatelessWidget {
  // Image 안에 넣을 이미지 출처
  final ImageProvider avatarImage;

  // 이미지 위젯
  final List<Image> images;
  final int rating;
  final String email;
  final String content;

  const RatingCard({required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
    super.key});

  factory RatingCard.fromModel({
    required RatingModel ratingModel
  }) {
    return RatingCard(
        avatarImage: NetworkImage(ratingModel.user.imageUrl),
        images: ratingModel.imgUrls.map((e) => Image.network(e)).toList(),
        rating: ratingModel.rating,
        email: ratingModel.user.username,
        content: ratingModel.content
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(rating: rating, avatarImage: avatarImage, email: email,),
        const SizedBox(height: 8.0,),
        _Body(content: content,),
        const SizedBox(height: 8.0,),
        if (images.length > 0) SizedBox(
            height: 100, child: _Images(images: images,)),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final int rating;
  final String email;

  const _Header(
      { required this.avatarImage, required this.rating, required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 12.0, backgroundImage: avatarImage,),
        const SizedBox(width: 8.0,),
        Expanded(child: Text(email, overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500),)),
        ...List.generate(5, (index) =>
            Icon(index < rating ? Icons.star : Icons.star_border_outlined,
              color: PRIMARY_COLOR,)),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({ required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(content,
            style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0,),),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;

  const _Images({required this.images, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images.mapIndexed((index, e) =>
          Padding(
            padding: EdgeInsets.only(
                right: index == images.length - 1 ? 0 : 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: e,
            ),
          )).toList(),
    );
  }
}
