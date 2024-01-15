import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project07/layout/default_layout.dart';
import 'package:project07/riverpod/listen_provider.dart';

class ListenProviderScreen extends ConsumerStatefulWidget {
  const ListenProviderScreen({super.key});

  @override
  ConsumerState<ListenProviderScreen> createState() =>
      _ListenProviderScreenState();
}

class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    // initState에서는 watch ㄴㄴ 단발적으로만 읽음
    controller = TabController(
        length: 10, vsync: this, initialIndex: ref.read(listenProvider));
  }

  @override
  Widget build(BuildContext context) {
    // ref.watch와 ref.listen의 주요한 차이점은
    // ref.watch는 프로바이더 상태값이 변경이 되면 widget/provider을 다시 빌드하지만
    // ref.listen은 함수를 호출한다는 점입니다.
    // listen은 dispose할 필요 없음 중복으로 listen 안되게 설계
    ref.listen<int>(listenProvider, (previous, next) {

      // 페이지가 변경되면 next 페이지로 이동해라
      if (previous != next) {
        controller.animateTo(
          next,
        );
      }
    });

    return DefaultLayout(
        title: "ListenProviderScreen",
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: List.generate(
              10,
              (index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(index.toString()),
                      ElevatedButton(
                          onPressed: () {
                            ref.read(listenProvider.notifier).update(
                                  (state) => state == 9 ? 9 : state + 1,
                                );
                          },
                          child: Text("다음")),
                      ElevatedButton(
                          onPressed: () {
                            ref.read(listenProvider.notifier).update(
                                  (state) => state == 0 ? 0 : state - 1,
                                );
                          },
                          child: Text("뒤로"))
                    ],
                  )),
        ));
  }
}
