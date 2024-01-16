import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project06/common/const/colors.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/common/layout/default_layout.dart';
import 'package:project06/common/provider/dio_provider.dart';
import 'package:project06/common/provider/secure_storage_provider.dart';
import 'package:project06/common/view/root_tab.dart';
import 'package:project06/user/view/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // deleteToken();
    checkToken();
  }

  void checkToken() async {
    final dio = ref.read(dioProvider);
    final storage = ref.read(secureStorageProvider);

    // initstate에서 await할 수 없음
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
      return;
    }

    try {
      // refreshToken이 유효한지 시도
      final path = "http://$ip/auth/token";

      final response = await dio.post(path,
          options: Options(headers: {'authorization': 'Bearer $refreshToken'}));

      // 새로 받아온 AT 저장
      await storage.write(key: ACCESS_TOKEN_KEY, value: response.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => RootTab()), (route) => false);
    } catch(err) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    }
  }

  void deleteToken() async {
    final storage = ref.read(secureStorageProvider);
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("asset/img/logo/logo.png",
                  width: MediaQuery.of(context).size.width / 2),
              const SizedBox(
                height: 16.0,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}
