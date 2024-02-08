import 'package:dio/dio.dart' hide Headers;
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/model/pagination_params.dart';
import 'package:project06/common/repository/base_pagination_repository.dart';
import 'package:project06/rating/model/rating_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rating_repository.g.dart';

@RestApi()
abstract class RatingRepository implements IBasePaginationRepository<RatingModel> {
  factory RatingRepository(Dio dio, {String baseUrl}) = _RatingRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true'
  })
  Future<CursorPagination<RatingModel>> paginate({ @Queries() PaginationParams? paginationParams = const PaginationParams() });
}