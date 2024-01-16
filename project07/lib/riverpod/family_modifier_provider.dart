import 'package:flutter_riverpod/flutter_riverpod.dart';

// int인 data를 외부에서 받아서 List<int>인 ref 리턴함
// parameter를 여러 개 전달하는 것은 불가능하지만 클래스화해서 전달하는 건 가능
final familyModifierProvider = FutureProvider.family<List<int>, int>((ref, data) async {
  await Future.delayed(Duration(seconds: 2));

  return List.generate(5, (index) => index * data);
});