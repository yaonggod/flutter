# Provider

## 종류

- Provider
  - 기본 Provider
  - 아무 타입이나 반환 가능
  - service, 계산한 값 등을 반환할 때 사용
  - 반환값을 캐싱할 때 유용하게 사용
    - 빌드 횟수 최소화 가능
  - 여러 Provider의 값들을 묶어서 한번에 반환값을 만들어 낼 수 있음 
- StateProvider
  - UI에서 직접적으로 데이터를 변경하고 싶을 때 사용
  - 단순한 형태의 데이터만 관리(int, double, String), Map, List 등 복잡한 데이터는 다루지 않음
  - 복잡한 로직은 다루지 않음, number++ 정도
- StateNotifierProvider
  - UI에서 직접적으로 데이터를 변경하고 싶을 때 사용
  - 복잡한 형태의 데이터 관리 가능 - 클래스의 메소드를 이용한 상태관리
  - StateNotifier를 상속한 클래스를 반환 
- FutureProvider
  - Future 반환
  - API 요청의 결과를 반환할 때 자주 사용
  - 복잡한 로직 또는 사용자의 특정 행동 뒤에 Future를 재실행하는 기능이 없음
    - 필요시 StateNotifierProvider 사용
- StreamProvider
  - Stream 반환
  - API 요청의 결과를 Stream으로 반환할 때 자주 사용
    - Socket 
- ~~ChangeNotifierProvider~~ 사용 안함, Provider 마이그레이션 용도

## 특징

- 각각 다른 타입을 반환해주고 사용 목적이 다름
- 모른 Provider는 글로벌하게 선언 

## [ref.read vs ref.watch vs ref.listen](https://riverpod.dev/ko/docs/concepts/reading#reflisten%EC%9D%84-%EC%82%AC%EC%9A%A9%ED%95%98%EC%97%AC-%ED%94%84%EB%A1%9C%EB%B0%94%EC%9D%B4%EB%8D%94-%EB%B3%80%ED%99%94%EC%97%90-%EB%8C%80%EC%9D%91%ED%95%98%EA%B8%B0)

- ref.watch
  - 반환값의 업데이트가 있을 시 지속적으로 build함수 재실행
  - 필수적으로 UI관련 코드에만 사용
- ref.read
  - 실행되는 순간에만 provider 값을 가져옴
  - onPressed 콜백처럼 특정 액션 뒤에 실행되는 함수 내부에서 사용 

- ref.listen
  - 반환값의 업데이트가 있을 시 특정 함수를 호출 

## Code Generation

```flutter pub run build_runner watch```

```yaml
dependencies:
  flutter_riverpod: ^2.4.9
  riverpod_annotation: ^2.3.3
dev_dependencies:
  build_runner: ^2.4.8
  riverpod_generator: ^2.3.9
```

일반 함수의 형태로 생성

```dart
@riverpod
String gState(GStateRef ref) {
  return "Hello Code Generation";
}
```

AutoDispose 아님

```dart
@Riverpod(keepAlive: true)
Future<int> gStateFuture2(GStateFuture2Ref ref) async {
  await Future.delayed(Duration(seconds: 3));
  return 11;
}
```

family -> parameter 여러 개 넣는 provider 생성 가능 

```dart
@riverpod
int gStateMultiply(GStateMultiplyRef ref, {
  required int number1,
  required int number2,
}) {
  return number1 * number2;
}
```

StateNotifierProvider

```dart
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
```

