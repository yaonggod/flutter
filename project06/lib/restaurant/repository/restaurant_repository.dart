import 'package:dio/dio.dart' hide Headers;
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/restaurant/model/restaurant_detail_model.dart';
import 'package:project06/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // abstract으로 선언하고 있어야 하는 함수들만 body없이 선언

  @GET("/")
  @Headers({
    'accessToken': 'true'
  })
  Future<CursorPagination<RestaurantModel>> paginate();

  @GET('/{id}')
  @Headers({
    'accessToken': 'true'
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
