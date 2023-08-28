# dart_async_programming

sync : cpu가 한 작업만 담당해서 순차적으로 요청 처리, 서버에 요청을 보내고 응답이 오는 동안 cpu를 다른 작업에 할당할 수 없음

async : 여러 작업을 동시다발적으로 처리

```dart
void addNumbers(int n1, int n2) {
  // 1
  print('계산 시작: $n1 + $n2');
  
  // 2
  // Duration(지연할 시간), Function(시간 경과 후 실행할 함수)
  Future.delayed(Duration(seconds: 2), () {
    print('계산 완료: ${n1 + n2}');
  });
  
  // 3
  print('함수 완료');
}
// 1 -> 2 -> 3 이 아니라 1, 2, 3 같이 실행
// 계산 시작: 1 + 2
// 함수 완료
// (2초후)계산 완료: 3
```

## await

응애 순서대로 해줘 or 이거 받아오고 이거로 저거 해줘

async - await : await를 기다렸다가 다음 거를 해줘 

```dart
void main() async {
  await addNumbers(1, 2);
  await addNumbers(2, 3);
}
```

await은 Future만 리턴함(js Promise같은거)

```dart
Future<void> addNumbers(int n1, int n2) async {
  print('계산 시작: $n1 + $n2');
  
  await Future.delayed(Duration(seconds: 2), () {
    print('계산 완료: ${n1 + n2}');
  });
  
  print('함수 완료');
}
```

함수 내에서 await 써도 cpu는 알아서 할 일 찾아서 함, 함수 안에서만 순서 지킴

## stream

stream을 닫을때까지 반환값을 받음 

```dart
import 'dart:async';

void main() {
  final controller = StreamController();
  
  // stream에서 val을 여러번 받기 위해 broadcastStream으로 만들기
  final stream = controller.stream.asBroadcastStream();
  
  // listener에 val이 들어오면 함수 실행
  // where조건으로 값 걸러서 받기
  final streamListener1 = stream.where((val) => val % 2 == 0).listen((val) {
    print('Listener1 : $val');
  });
  
  final streamListener2 = stream.where((val) => val % 2 == 1).listen((val) {
    print('Listener2 : $val');
  });
  
  // val 넣기
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);
  controller.sink.add(5);
    
  // Listener2 : 1
  // Listener1 : 2
  // Listener2 : 3
  // Listener1 : 4
  // Listener2 : 5
}
```

return(=> yield)이 여러번 나와야 하는 함수를 stream으로 듣기

```dart
void main() {
  calculate(3).listen((val) {
    print(val);
  });
}

Stream<int> calculate(int num) async* {
  for (int i = 1; i < 6; i++) {
    yield i * num;
  }
}
```

stream 내부에서 await하기

```dart
Stream<int> calculate(int num) async* {
  for (int i = 1; i < 6; i++) {
    yield i * num;
    
    await Future.delayed(Duration(seconds: 1));
  }
}
```

개별 stream을 순차적으로 await하기

```dart
Stream<int> playAllStream() async* {
  yield* calculate(1);
  yield* calculate(1000);
}
```

```dart
void main() {
  playAllStream().listen((val) {
   print(val); 
  });
}
```

