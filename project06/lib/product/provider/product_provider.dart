import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/model/cursor_pagination_model.dart';
import 'package:project06/common/provider/pagination_provider.dart';
import 'package:project06/product/model/product_model.dart';
import 'package:project06/product/provider/product_repository_provider.dart';
import 'package:project06/product/repository/product_repository.dart';

final productProvider = StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductStateNotifier(repository: repository);
});

class ProductStateNotifier
    extends PaginationProvider<ProductModel, ProductRepository> {
  ProductStateNotifier({required super.repository});
}
