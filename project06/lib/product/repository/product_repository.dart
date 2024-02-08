import 'package:dio/dio.dart' hide Headers;
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/model/pagination_params.dart';
import 'package:project06/common/repository/base_pagination_repository.dart';
import 'package:project06/product/model/product_model.dart';
import 'package:retrofit/retrofit.dart';

part 'product_repository.g.dart';

@RestApi()
abstract class ProductRepository implements IBasePaginationRepository<ProductModel> {
  factory ProductRepository(Dio dio, { String baseUrl }) = _ProductRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true'
  })
  @override
  Future<CursorPagination<ProductModel>> paginate({ @Queries() PaginationParams? paginationParams = const PaginationParams()});
}