import 'package:flutter_riverpod/flutter_riverpod.dart';

final multipleFutureProvider = FutureProvider<List<int>>((ref) async {
  // 로딩 한 번 하면 없어짐
  await Future.delayed(Duration(
    seconds: 2,
  ));

  // throw Exception("에러");
  return [1, 2, 3, 4, 5];
});