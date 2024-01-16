import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// flutter pub run build_runner build

// 어떤 provider를 사용할지 고민할 필요 없도록
// Provider, FutureProvider, StreamProvider?
// StateNotifierProvider

final _testProvider = Provider<String>((ref) => "Hello Code Generation");

// AutoDispose
// String 타입을 리턴하는 provider를 만들고 싶음
@riverpod
String gState(GStateRef ref) {
  return "Hello Code Generation";
}

// future
@riverpod
Future<int> gStateFuture(GStateFutureRef ref) async {
  await Future.delayed(Duration(seconds: 3));
  return 10;
}

// AutoDispose 아님 - keepAlive: false가 기본
@Riverpod(keepAlive: true)
Future<int> gStateFuture2(GStateFuture2Ref ref) async {
  await Future.delayed(Duration(seconds: 3));
  return 11;
}

// parameter > family 파라미터를 일반 함수처럼 사용할 수 있도록
class Parameter {
  final int number1;
  final int number2;

  Parameter({required this.number1, required this.number2});
}

final _testFamilyProvider = Provider.family<int, Parameter>(
  (ref, parameter) => parameter.number1 * parameter.number2,
);

@riverpod
int gStateMultiply(GStateMultiplyRef ref, {
  required int number1,
  required int number2,
}) {
  return number1 * number2;
}

// StateNotifierProvider
@riverpod
class GStateNotifier extends _$GStateNotifier {
  // 초기 상태값 지정
  @override
  int build() {
    return 0;
  }
  
  plus() { state++; }
  minus() { state--; }
}