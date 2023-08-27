# dart_oop

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

### constructor

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

### final

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

### const constructor

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

### getter setter

```dart
get firstMember {
    return this.members[0];
}

print(bts.firstMember);
```

```dart
set firstMember(String newMember) {
    this.members[0] = newMember;
}

bts.firstMember = '정우';
print(bts.firstMember);
```



