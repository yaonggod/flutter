import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/common/provider/dio_provider.dart';
import 'package:project06/rating/repository/rating_repository.dart';

final ratingRepositoryProvider =
    Provider.family<RatingRepository, String>((ref, id) {
  final dio = ref.watch(dioProvider);
  final repository =
      RatingRepository(dio, baseUrl: "http://$ip/restaurant/$id/rating");
  return repository;
});
