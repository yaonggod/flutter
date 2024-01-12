import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project06/common/const/data.dart';

class CustomInterceptor extends Interceptor {

  final FlutterSecureStorage storage;
  CustomInterceptor({ required this.storage });

  // 1. 요청을 보낼 때
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] [${options.uri}]');

    // AT가 필요한 요청은 AT를 넣어서 요청을 보내기
    if (options.headers['accessToken'] == 'true') {

      // AT header 지우고
      options.headers.remove('accessToken');

      // storage에서 실제 AT 가져오기
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

      // header에 실제 AT 넣기
      options.headers.addAll({
        'authorization': 'Bearer $accessToken',
      });
    }

    // RT가 필요한 요청은 RT를 넣어서 요청을 보내기
    if (options.headers['refreshToken'] == 'true') {

      // RT header 지우고
      options.headers.remove('refreshToken');

      // storage에서 실제 RT 가져오기
      final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

      // header에 실제 RT 넣기
      options.headers.addAll({
        'authorization': 'Bearer $refreshToken',
      });
    }

    super.onRequest(options, handler);
  }

  // 2. 응답을 받을 때
  // 3. 에러가 났을 떄

}