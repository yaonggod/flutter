import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/user/provider/auth_provider.dart';

class CustomInterceptor extends Interceptor {

  final FlutterSecureStorage storage;
  final Ref ref;
  CustomInterceptor({ required this.storage, required this.ref });

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

    // 요청을 보내기
    return super.onRequest(options, handler);
  }

  // 2. 응답을 받을 때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] [${response.requestOptions.method}] [${response.requestOptions.uri}]');
    return super.onResponse(response, handler);
  }

  // 3. 에러가 났을 때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('[ERR] [${err.requestOptions.method}] [${err.requestOptions.uri}]');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken마저 없을 시 에러 내고 끝
    if (refreshToken == null) {
      return handler.reject(err);
    }

    // 401 - 토큰 재발급 필요 -> 재발급 후 새 토큰으로 요청
    final isStatus401 = err.response?.statusCode == 401;

    // refreshToken을 넣어서 토큰을 refresh하는 요청을 보낸 경우
    final isPathRefresh = err.requestOptions.path == "/auth/token";

    // AT가 만료됨
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();
      try {

        // RT 보내서 refresh하자
        final response = await dio.post(
            'http://$ip/auth/token', options: Options(headers: { 'authorization' : 'Bearer $refreshToken' })
        );
        final accessToken = response.data['accessToken'];

        // 발급받은 AT를 다시 넣자
        final options = err.requestOptions;
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        // 새로받은 AT를 storage에 저장하기
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 에러를 발생시킨 옵션을 AT를 바꾼 뒤 다시 가져와서 원래 요청을 다시 보내기
        final response2 = await dio.fetch(options);

        // 요청이 잘 왔으면 그거를 리턴하면됨
        return handler.resolve(response2);

      } on DioException catch (e) {
        // RT도 만료되어서 에러

        // circular dependency error
        // a -> b -> a -> b -> ...
        // 지금 이 메소드가 dio를 build할 때 필요한 interceptor 안에 있는데
        // usermeprovider는 dio가 필요한데 dio는 usermeprovider가 필요함
        // dio가 필요없는 provider에서 로그아웃 로직을 끌어와서 하기

        ref.read(authProvider.notifier).logout();
        return handler.reject(e);
      }

    }
    // 에러인데 AT를 refresh하는 요청이 아님 -> handle안해
    return handler.reject(err);
  }

}