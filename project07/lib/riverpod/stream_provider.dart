import 'package:flutter_riverpod/flutter_riverpod.dart';

// Stream을 받는 경우 async* 사용
final multipleStreamProvider = StreamProvider((ref) async* {
  // for loop이 모두 끝난 경우 stream 수행
  for (int i = 0; i < 10; i++) {
    await Future.delayed(Duration(seconds: 1));

    yield List.generate(3, (index) => index * i);
}
});