import 'package:dio/dio.dart' hide Headers;
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/model/pagination_params.dart';
import 'package:project06/common/repository/base_pagination_repository.dart';
import 'package:project06/restaurant/model/restaurant_detail_model.dart';
import 'package:project06/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

// 기본 pagination repository를 implement하기
@RestApi()
abstract class RestaurantRepository implements IBasePaginationRepository<RestaurantModel>{
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET("/")
  @Headers({
    'accessToken': 'true'
  })
  Future<CursorPagination<RestaurantModel>> paginate({ @Queries() PaginationParams? paginationParams = const PaginationParams() });

  @GET('/{id}')
  @Headers({
    'accessToken': 'true'
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
