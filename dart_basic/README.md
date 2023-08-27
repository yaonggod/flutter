# dart_basic

## 프린트

```dart
void main() {
    print('hello world')
}
```

## 변수 선언

- 재선언 X, 재할당 O

```dart
var name = 'yaong';
name = 'mungmung';
```

## 타입

### 정수(integer)

```dart
int number1 = 10;
```

### 실수(double)

```dart
double number1 = 1.5;
```

### boolean

```dart
bool isTrue = true;
bool isFalse = false;
```

### String

```dart
String name = 'yaong';
```

변수 타입 유추

```dart
var name = 'yaong';
print(name.runtimeType); // String

var number = 1;
print(number.runtimeType); // int
```

String 더하기

```dart
String name = 'yaong';
print(name + '님'); // yaong님
print(name + name); // yaongyaong
```

String 변수 넣기

```dart
print('${name}님');
print('$name님');
```

### dynamic

```dart
dynamic name = 'yaong';
print(name);

dynamic number = 1;
print(number);
```

dynamic과 var의 차이

dynamic은 재할당 시 타입을 바꿀 수 있음

```dart
dynamic name = 'yaong';
name = 1
```

var는 안됨, 처음 선언 시 타입이 픽스됨

```dart
var name = 'yaong';
name = 1;
print(name)

Error: A value of type 'int' can't be assigned to a variable of type 'String'.
```

## nullable, non-nullable

`null` 아무런 값도 있지 않다

타입 뒤에 ?를 붙이면 null도 들어갈 수 있음

```dart
String name = 'yaong';
name = null
    
String? name = 'yaong';
name = null;
```

변수 뒤에 !를 붙이면 절대로 null이 아니라는 뜻

 ```dart
 print(name!);
 ```

## final, const

final, const로 선언하면 값 재할당 불가

```dart
final String name1 = 'yaong';
const String name2 = 'mungmung';

name = 'mungmung'
```

타입 검사도 해줌

```dart
final name = 'yaong';
```

둘의 차이?

```dart
// 빌드타임의 값을 몰라도됨 => 정상 작동
final DateTime now = DateTime.now();
print(now);

// 빌드타임의 값을 알아야 함 => 에러
const DateTime now2 = DateTime.now();
print(now2);
```

## operator

```dart
int number = 2;

print(number + 2);
print(number - 2);
print(number * 2);
print(number / 2);
print(number % 2);

print(++number);
print(--number);

number += 1;
print(number);
```

### null조건

```dart
double? number = 4.0;

number = null;
print(number);

// 만약 number가 null이면 오른쪽 값으로 바꾸기
number ??= 3.0;
print(number);
```

### 비교

```dart
int number1 = 1;
int number2 = 2;
print(number1 > number2);
print(number1 == number2);
print(number1 != number2);
```

### 타입 검사

```dart
int number1 = 1;
print(number1 is int);
print(number1 is! int);
```

### 논리

```dart
bool result = !(12 > 10) && 1 > 0;
result = 12 > 10 || 1 > 0;
print(result);
```

## List

```dart
List<String> list = ['yaong', 'mungmung'];
List<int> nums = [1, 2, 3, 4];
```

### 인덱스

```dart
print(nums[1]);
```

### 메소드

```dart
// 리스트 길이
print(nums.length);
// 원소 append
nums.add(5);
// 원소 삭제
nums.remove(2);
// 인덱스 찾기
print(nums.indexOf(3));
```

## Map

```dart
Map<String, String> dict = {
	'cat': 'yaong',
	'dog': 'mungmung'
};

print(dict['cat']);
```

추가

```dart
dict.addAll({
    'bird': 'zz',
    'bug': 'bugg'
});
dict['human'] = 'me';
```

삭제

```dart
dict.remove('bug');
```

key만, value만

```dart
print(dict.keys);
print(dict.values);
```

## Set

```dart
final Set<int> set = {1, 2, 2, 3, 4, 4};
print(set); // {1, 2, 3, 4}
```

추가

```dart
set.add(5);
```

삭제

```dart
set.remove(4);
```

값이 존재?

```dart
print(set.contains(632));
```

## if

```dart
int number = 1;
if (number % 3 == 0) {
	print(0);
} else if (number % 3 == 1) {
	print(1);
} else {
    print(2);
}
```

## switch

```dart
int number = 1;

switch(number % 3) {
    case 0:
      print(0);
      break;
    case 1:
      print(1);
      break;
    default:
      print(2);
      break;
}
```

## loop

### for

```dart
for (int i = 0; i < 5; i++) {
    print(i);
}
```

```dart
List<int> list = [1, 2, 3, 4, 5];

for (int i = 0; i < list.length; i++) {
	print(list[i]);
}

for (int i in list) {
    print(i);
}
```

### while

```dart
int number = 1;

while (number < 6) {
    print(number);
    number++;
}
```

```dart
do {
    total += 1;
} while (total < 10);
```

### break

```dart
while (number < 6) {
    // 전체 loop 그만하기
    if (number == 3) break;
    print(number);
    number++;
}
```

### continue

```dart
for (int i = 0; i < 5; i++) {
    // 지금 loop만 하지마
    if (i == 3) continue;
    print(i);
}
```

## enum

```dart
// 세 가지 타입만 강제
enum Status {
  approved, // 승인
  pending, // 대기
  rejected, // 거절
}

void main() {
  Status status = Status.pending;

  if (status == Status.approved) {
    print('승인');
  } else if (status == Status.pending) {
    print('대기');
  } else {
    print('거절');
  }
}
```

## 함수

```dart
void main() {
  print(addNum(1, 2, 4));
}

// 세 개의 숫자를 더하고 짝홀 알려주는 함수
String addNum(int x, int y, int z) {
  if ((x + y + z) % 2 == 0) {
      return '짝수';
  }
  return '홀수';
}
```

### positional parameter

순서 중요함, x y z 순서 맞춰서 넣음

### optional parameter

넣어도 되고 안 넣어도 되는데 안넣으면 null이 될 수 있다고 하거나 default 넣기

```dart
String addNum(int x, [int y = 2, int z = 3]) {
  if ((x + y + z) % 2 == 0) {
    return '짝수';
  }
  return '홀수';
}
```

### named parameter

순서는 안중요한데 이름 따라감

```dart
void main() {
  print(addNum(x: 2, z: 3, y: 4));
}

addNum({required int x, required int y, required int z}) {
  if ((x + y + z) % 2 == 0) {
    return '짝수';
  }
  return '홀수';
}
```

named에 optional 넣기

```dart
void main() {
  print(addNum(x: 2, y: 4));
}

addNum({required int x, required int y, int z = 3}) {
  if ((x + y + z) % 2 == 0) {
    return '짝수';
  }
  return '홀수';
}
```

### 리턴 타입

`void` 리턴 없음

`int` `String` `bool` 등등

타입 안넣어줘도 돌아가기는 함

### 화살표 함수

```dart
void main() {
  print(addNum(1, 2, 3));
}

addNum(int x, int y, int z) => x + y + z;
```

### typedef

type이 같은 (return, parameter 다 같은) 함수 넣어서 사용

```dart
void main() {
  Operation operation = add;
  print(operation(1, 2, 3));

  operation = subtract;
  print(operation(1, 2, 3));
    
  print(calc(1, 2, 3, add));
  print(calc(1, 2, 3, subtract));
}

// signature
typedef Operation = int Function(int x, int y, int z);

// 더하기
int add(int x, int y, int z) => x + y + z;
// 빼기
int subtract(int x, int y, int z) => x - y - z;

int calc(int x, int y, int z, Operation op) {
  return op(x, y, z);
}
```
