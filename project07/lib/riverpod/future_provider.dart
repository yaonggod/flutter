import 'package:flutter_riverpod/flutter_riverpod.dart';

final multipleFutureProvider = FutureProvider<List<int>>((ref) async {
  // 로딩 한 번 하면 완료 -> 다음에 다시 build되면 로딩 안함
  await Future.delayed(Duration(
    seconds: 2,
  ));

  // throw Exception("에러");
  return [1, 2, 3, 4, 5];
});