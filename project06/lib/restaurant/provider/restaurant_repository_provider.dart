import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/common/provider/dio_provider.dart';
import 'package:project06/restaurant/repository/restaurant_repository.dart';

final restaurantRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final repository = RestaurantRepository(dio, baseUrl: "http://$ip/restaurant");
  return repository;
});