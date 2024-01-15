import 'package:flutter_riverpod/flutter_riverpod.dart';

final autoDisposeModifierProvider = FutureProvider.autoDispose<List<int>>((ref) async {
  // 캐싱 ㄴㄴ 화면에 위젯이 dispose되면 자동으로 캐시 삭제 
  await Future.delayed(Duration(seconds: 2));

  return [1, 2, 3, 4, 5];
});
