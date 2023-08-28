# dart_oop

모든 클래스는 Object를 상속받음 

## class

```dart
class Idol {
  // 변수
  String name;
  List<String> members;
  
  // 생성자
  Idol(String name, List<String> members)
    : this.name = name,
      this.members = members;
  
  // 메소드
  String sayHello() {
    return '안녕하세요 ${this.name}입니다.';
  }
  String introduce() {
    String mem = '';
    for (String m in this.members) {
      mem += m;
      mem += ' '; 
    }
    return '저희 멤버는 ' + mem + '입니다.';
  }
}
```

## constructor

```dart
Idol(String name, List<String> members)
    : this.name = name,
      this.members = members;
```

```dart
Idol(this.name, this.members);
```

```dart
Idol.fromList(List values)
 	: this.name = values[0],
	  this.members = values[1];
```

## final

인스턴스를 선언할 때 변수를 final로 선언

```dart
final String name;
final List<String> members;
```

나중에 인스턴스의 변수를 마음대로 못 바꾸게

```dart
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
bts.name = '블랙핑크';
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

## const constructor

```dart
const Idol(this.name, this.members);
```

```dart
Idol bts = const Idol(
    'BTS',
    ['진', 'RM', '제이홉', '슈가', '뷔', '지민', '정국'],
);
```

원래 같은 변수를 가진 인스턴스는 다른 메모리 주소를 가지고 있어서 같은 인스턴스가 아닌데,
const constructor는 같은 인스턴스가 됨

```dart
Idol bts = const Idol(
    'BTS',
    ['진', 'RM', '제이홉', '슈가', '뷔', '지민', '정국'],
);
Idol bts2 = const Idol(
    'BTS',
    ['진', 'RM', '제이홉', '슈가', '뷔', '지민', '정국'],
);
print(bts == bts2) // true
```

## getter setter

```dart
String getFirstMember() {
    return this.members[0];
}

get firstMember {
    return this.members[0];
}

print(bts.getFirstMember());
print(bts.firstMember);
```

setter는 잘 안씀 - final과 상충함

```dart
set firstMember(String newMember) {
    this.members[0] = newMember;
}

bts.firstMember = '정우';
print(bts.firstMember);
```

## private

변수, 메소드, 클래스를 외부 파일에서 못쓰게 _를 붙임 

```dart
class _Idol {
    
}
```

```dart
_Idol bts = const _Idol(
    'BTS',
    ['진', 'RM', '제이홉', '슈가', '뷔', '지민', '정국'],
);
```

## 상속

**속성과 메소드를 물려줌**

부모 클래스

```dart
class Idol {
  String name;
  int membersCount;
  
  Idol({
    required this.name,
    required this.membersCount
  });
  
  void introduce() {
    print('${this.name}은 ${this.membersCount}명의 멤버가 있습니다.');
  }  
}
```

자식 클래스

```dart
class BoyGroup extends Idol {
  // 생성자가 순서대로 name과 membersCount를 받아서 부모 생성자의 name과 membersCount에 연결시키기
  BoyGroup(String name, int membersCount): super(
    name: name,
    membersCount: membersCount,
  );
  
  // 자식 클래스만의 고유한 변수와 메소드
  String gender = '남자';
  void sayGender() {
    print('저는 ${this.gender}입니다.');
  }
}
```

```dart
BoyGroup nct = BoyGroup('NCT', 20);
nct.introduce(); // NCT은 20명의 멤버가 있습니다.
nct.sayGender(); // 저는 남자입니다.

print(nct is BoyGroup); // true
print(nct is Idol); // true
```

## method override

덮어쓴 메소드를 기존 메소드보다 우선시하기

```dart
class TimesTwo{
  final int number;
  TimesTwo(this.number);
  
  int calculate() {
    return number * 2;
  }
}

class TimesFour extends TimesTwo{
  TimesFour(int number): super(number);
  
  @override
  int calculate() {
    // this.number == super.number(정석) == number
    return super.number * 4;
  }
}
```

부모 클래스의 메소드를 기반으로 오버라이드

```dart
@override
int calculate() {
  return super.calculate() * 2;
}
```

```dart
TimesTwo tt = TimesTwo(2);
print(tt.calculate()); // 4
  
TimesFour tf = TimesFour(2);
print(tf.calculate()); // 8
```

## static

non-static => 한 인스턴스의 변수를 바꿔도 다른 인스턴스에 영향 X, 인터페이스에 귀속됨

static => 클래스 자체의 변수를 바꿈, 클래스에 귀속됨 

```dart
class Employee {
  // 근무지
  static String? building;
  // 이름
  final String name;
  
  Employee(this.name);
  
  void introduce() {
    print('저는 $name입니다. $building에서 근무중입니다.');
  }
  
  void where() {
    print('저는 $building에서 근무중입니다.');
  }
}
```

```dart
// 인스턴스에 귀속
Employee yaong = Employee('yaong');
Employee mungmung = Employee('mungmung');

// 클래스에 귀속
Employee.building = '402';
```

## 인터페이스

구현하는 클래스에게 **인터페이스의 구조를 강제**

```dart
// 인터페이스로는 인스턴스를 만들지 않음, abstract 선언
abstract class IdolInterface{
  String name;
  IdolInterface(this.name);
  void sayName();
}

class BoyGroup implements IdolInterface {
  String name;
  BoyGroup(this.name);
  void sayName() {
    print('제 이름은 $name입니다.');
  }
}
```

## generic

타입을 외부에서 받음

```dart
class Lecture<T, F> {
  final T id;
  final F name;
  
  Lecture(this.id, this.name);
}
```

```dart
Lecture<int, String> lecture2 = Lecture(3, 'mungmung');
```
