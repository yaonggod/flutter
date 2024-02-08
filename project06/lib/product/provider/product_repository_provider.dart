import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/common/provider/dio_provider.dart';
import 'package:project06/product/repository/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);
  
  return ProductRepository(dio, baseUrl: "http://$ip/product");
});