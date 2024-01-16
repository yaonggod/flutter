import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/dio/dio.dart';
import 'package:project06/common/provider/secure_storage_provider.dart';

final dioProvider = Provider((ref) {

  print('dio build');

  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(CustomInterceptor(storage: storage));

  return dio;
});