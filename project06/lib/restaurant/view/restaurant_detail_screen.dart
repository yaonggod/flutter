import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/const/colors.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/common/dio/dio.dart';
import 'package:project06/common/layout/default_layout.dart';
import 'package:project06/common/provider/dio_provider.dart';
import 'package:project06/product/component/product_card.dart';
import 'package:project06/product/model/product_model.dart';
import 'package:project06/restaurant/component/restaurant_card.dart';
import 'package:project06/restaurant/model/restaurant_detail_model.dart';
import 'package:project06/restaurant/model/restaurant_model.dart';
import 'package:project06/restaurant/repository/restaurant_repository.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;
  final String name;
  const RestaurantDetailScreen({required this.id, required this.name, super.key});

  Future<RestaurantDetailModel> getRestaurant(WidgetRef ref) async {
    // final dio = Dio();
    //
    // // interceptor 추가
    // dio.interceptors.add(
    //   CustomInterceptor(storage: storage),
    // );

    // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    // final response = await dio.get("http://$ip/restaurant/$id",
    //     options: Options(headers: {"authorization": 'Bearer $accessToken'}));
    // return response.data;

    final dio = ref.watch(dioProvider);
    final repository = RestaurantRepository(dio, baseUrl: "http://$ip/restaurant");
    return repository.getRestaurantDetail(id: id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
        title: name,
        child: FutureBuilder<RestaurantDetailModel>(
          future: getRestaurant(ref),
          builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshot) {
            if (!snapshot.hasData) return Container();

            // final restaurant = RestaurantDetailModel.fromJson(snapshot.data!);

            return CustomScrollView(
              slivers: [
                renderTop(restaurantModel: snapshot.data!),
                renderLabel(),
                renderProducts(products: snapshot.data!.products),
                SliverToBoxAdapter(child: SizedBox(height: 32.0,),),
              ],
            );
          },
        ));
  }
}

SliverToBoxAdapter renderTop({ required RestaurantModel restaurantModel }) {
  return SliverToBoxAdapter(
    child: RestaurantCard.fromModel(restaurantModel: restaurantModel),
  );
}

SliverPadding renderProducts({ required List<ProductModel> products }) {
  return SliverPadding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final model = products[index];
        return Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
          ),
          child: ProductCard.fromModel(productModel: model),
        );
      }, childCount: products.length),
    ),
  );
}

SliverToBoxAdapter renderLabel() {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "메뉴",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18.0,
        ),
      ),
    ),
  );
}
