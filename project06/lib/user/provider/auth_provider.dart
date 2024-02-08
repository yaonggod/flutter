import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project06/common/view/root_tab.dart';
import 'package:project06/common/view/splash_screen.dart';
import 'package:project06/restaurant/view/basket_screen.dart';
import 'package:project06/restaurant/view/order_result_screen.dart';
import 'package:project06/restaurant/view/restaurant_detail_screen.dart';
import 'package:project06/user/model/user_model.dart';
import 'package:project06/user/provider/user_me_provider.dart';
import 'package:project06/user/view/login_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;
  AuthProvider({ required this.ref }) {

    // userMeProvider에 변경이 있을 경우에 알려줭
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) notifyListeners();
    }); }

  List<GoRoute> get routes => [
    // list의 최상단의 route에서 go를 선언하면 뒤로가기 안됨, 하위 route들과 같이 올라가서 여기서만 상위 route로 뒤로가기 가능
    // push를 하면 현재 route 위에 screen을 올리는 방식으로 이동
    GoRoute(
      path: '/',
      name: RootTab.routeName,
      builder: (_, __) => RootTab(),
      routes: [
        GoRoute(
          path: 'restaurant/:rid',
          name: RestaurantDetailScreen.routeName,
          builder: (_, state) => RestaurantDetailScreen(
            id: state.pathParameters['rid']!,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/basket',
      name: BasketScreen.routeName,
      builder: (_, state) => BasketScreen(),
    ),
    GoRoute(
      path: '/order_result',
      name: OrderResultScreen.routeName,
      builder: (_, state) => OrderResultScreen(),
    ),
    GoRoute(
      path: '/splash',
      name: SplashScreen.routeName,
      builder: (_, __) => SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.routeName,
      builder: (_, __) => LoginScreen(),
    ),
  ];

  // SplashScreen
  // 토큰 ? HomeScreen() : LoginScreen()
  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final loggingIn = state.matchedLocation == '/login';

    // 저장된 유저가 없는데 로그인중이 아니면 로그인스크린으로 보내줭
    if (user == null) {
      return loggingIn ? null : '/login';
    }

    // 유저가 있음 -> 로그인 화면이나 SplashScreen에 있으면 안됨, 홈으로 redirect
    if (user is UserModel) {
      return loggingIn || state.matchedLocation == '/splash' ? '/' : null;
    }

    // 에러 -> 로그인 다시
    if (user is UserModelError) {
      return !loggingIn ? '/login' : null;
    }

    return null;
  }

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }
}