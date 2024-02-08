import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project06/common/const/colors.dart';
import 'package:project06/common/layout/default_layout.dart';
import 'package:project06/common/view/root_tab.dart';
import 'package:project06/user/provider/basket_provider.dart';

class OrderResultScreen extends ConsumerWidget {
  static String get routeName => "orderResult";

  const OrderResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check, size: 100, color: PRIMARY_COLOR),
              Text("결제가 완료되었습니다.", style: TextStyle(fontSize: 18, color: PRIMARY_COLOR),),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    ref.read(basketProvider.notifier).resetBasket();
                    context.goNamed(RootTab.routeName);
                  },
                  child: Text("홈으로", style: TextStyle(color: Colors.white, fontSize: 18),),
                  style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)))),
            ],
          ),
        ));
  }
}
