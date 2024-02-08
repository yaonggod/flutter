import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/common/provider/dio_provider.dart';
import 'package:project06/user/repository/user_me_repository.dart';

final userMeRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final repository = UserMeRepository(dio, baseUrl: "http://$ip/user/me");
  return repository;
});