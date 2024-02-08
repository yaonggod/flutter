import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/model/pagination_params.dart';
import 'package:project06/common/provider/dio_provider.dart';
import 'package:project06/common/repository/base_pagination_repository.dart';
import 'package:project06/order/model/order_model.dart';
import 'package:project06/order/model/post_order_body.dart';
import 'package:retrofit/retrofit.dart';

part 'order_repository.g.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) =>
    OrderRepository(ref.watch(dioProvider), baseUrl: "http://$ip/order"));

@RestApi()
abstract class OrderRepository implements IBasePaginationRepository<OrderModel> {
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<OrderModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
});


  @POST('/')
  @Headers({'accessToken': 'true'})
  Future<OrderModel> postOrder({@Body() required PostOrderBody body});
}
