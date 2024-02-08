import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:project08/screens/10_transition_screen_1.dart';
import 'package:project08/screens/10_transition_screen_2.dart';
import 'package:project08/screens/11_error_screen.dart';
import 'package:project08/screens/1_basic_screen.dart';
import 'package:project08/screens/2_named_screen.dart';
import 'package:project08/screens/3_push_screen.dart';
import 'package:project08/screens/4_pop_base_screen.dart';
import 'package:project08/screens/5_pop_return_screen.dart';
import 'package:project08/screens/6_path_param_screen.dart';
import 'package:project08/screens/7_query_param_screen.dart';
import 'package:project08/screens/8_nested_child_screen.dart';
import 'package:project08/screens/8_nested_screen.dart';
import 'package:project08/screens/9_login_screen.dart';
import 'package:project08/screens/9_private_screen.dart';
import 'package:project08/screens/root_screen.dart';

// 로그인 여부
bool authState = false;

final router = GoRouter(
  // String - 해당 라우트로 이동
  // null - 원래 이동하려던 곳으로 이동
  redirect: (context, state) {
    if (state.matchedLocation == '/login/private' && !authState) {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => RootScreen(), routes: [
      GoRoute(
        path: 'basic',
        builder: (context, state) => BasicScreen(),
      ),
      GoRoute(
        path: 'named',
        name: 'named_screen',
        builder: (context, state) => NamedScreen(),
      ),
      GoRoute(
        path: 'push',
        name: 'push_screen',
        builder: (context, state) => PushScreen(),
      ),
      GoRoute(
        path: 'pop',
        name: 'pop_screen',
        builder: (context, state) => PopBaseScreen(),
        routes: [
          GoRoute(
            path: 'return',
            builder: (context, state) => PopReturnScreen(),
          )
        ],
      ),
      GoRoute(
        path: 'path_param/:id',
        builder: (context, state) => PathParamScreen(),
        routes: [
          GoRoute(
            path: ":name",
            builder: (context, state) => PathParamScreen(),
          ),
        ],
      ),
      GoRoute(
        path: 'query_param',
        builder: (context, state) => QueryParamScreen(),
      ),
      // path가 없는 대신 GoRoute 몇 개를 묶음
      ShellRoute(
          builder: (context, state, child) => NestedScreen(child: child),
          routes: [
            GoRoute(
              path: "nested/a",
              builder: (context, state) =>
                  NestedChildScreen(routeName: "/nested/a"),
            ),
            GoRoute(
              path: "nested/b",
              builder: (context, state) =>
                  NestedChildScreen(routeName: "/nested/b"),
            ),
            GoRoute(
              path: "nested/c",
              builder: (context, state) =>
                  NestedChildScreen(routeName: "/nested/c"),
            ),
          ]),
      GoRoute(
          path: 'login',
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: "private",
              builder: (context, state) => PrivateScreen(),
            ),
          ]),
      GoRoute(
          path: 'login2',
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: "private",
              builder: (context, state) => PrivateScreen(),
              redirect: (context, state) => !authState ? '/login2' : null,
            ),
          ]),
      GoRoute(
          path: "transition",
          builder: (context, state) => TransitionScreenOne(),
          routes: [
            GoRoute(
              path: 'detail',
              pageBuilder: (context, state) => CustomTransitionPage(
                  child: TransitionScreenTwo(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    // return FadeTransition(opacity: animation, child: child,);
                    return ScaleTransition(scale: animation, child: child,);
                  },),
            )
          ])
    ]),
  ],
  errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),
  debugLogDiagnostics: true,
);
