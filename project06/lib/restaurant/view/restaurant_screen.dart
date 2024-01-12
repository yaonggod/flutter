import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/restaurant/component/restaurant_card.dart';
import 'package:project06/restaurant/model/restaurant_model.dart';
import 'package:project06/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final response = await dio.get("http://$ip/restaurant",
        options: Options(headers: {"authorization": 'Bearer $accessToken'}));
    return response.data["data"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List>(
              future: paginateRestaurant(),
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData) return Container();

                return ListView.separated(
                    itemBuilder: (_, index) {
                      final pitem = RestaurantModel.fromJson(snapshot.data![index]);
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => RestaurantDetailScreen(id: pitem.id, name: pitem.name)
                                ),
                            );
                          },
                          child: RestaurantCard.fromModel(
                              restaurantModel: pitem));
                    },
                    separatorBuilder: (_, index) {
                      return SizedBox(
                        height: 16.0,
                      );
                    },
                    itemCount: snapshot.data!.length);
              },
            )),
      ),
    );
  }
}
