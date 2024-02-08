import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/common/provider/dio_provider.dart';
import 'package:project06/common/utils/data_utils.dart';
import 'package:project06/user/model/login_response.dart';
import 'package:project06/user/model/token_response.dart';

final authRepositoryProvider = Provider((ref) =>
    AuthRepository(dio: ref.watch(dioProvider), baseUrl: "http://$ip/auth"));

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({required this.dio, required this.baseUrl});

  Future<LoginResponse> login(
      {required String username, required String password}) async {
    final serialized = DataUtils.plainToBase64('$username:$password');
    final response = await dio.post("$baseUrl/login",
        options: Options(headers: {'authorization': 'Basic $serialized'}));

    return LoginResponse.fromJson(response.data);
  }

  Future<TokenResponse> token() async {
    final response = await dio.post("$baseUrl/token",
        options: Options(headers: {'refreshToken': 'true'}));
    return TokenResponse.fromJson(response.data);
  }
}
