# dart_functional_programming

## map()

```dart
List<String> nct = ['태용', '텐', '재현', '태용'];
  
final newNct = nct.map((x) {
  return 'nct $x';   
});

final newNct = nct.map((x) => 'nct $x');
  
print(newNct.toList()); // [nct 태용, nct 텐, nct 재현, nct 태용]
```

map 매핑하기

```dart
Map<String, String> nct = {
    '태용': 'nct127',
    '윈윈': 'WayV',
    '제노': 'nct dream'
};
  
final nctCurrent = nct.map((k, v) => MapEntry(
	'$k', 'nct, $v 소속입니다',
));

print(nctCurrent); // {태용: nct, nct127 소속입니다, 윈윈: nct, WayV 소속입니다, 제노: nct, nct dream 소속입니다}
```

key, value 매핑

```dart
final nctMembers = nct.keys.map((x) => 'nct $x').toList();
print(nctMembers); // [nct 태용, nct 윈윈, nct 제노]
```

set 매핑

```dart
Set nctSet = {'태용', '윈윈', '제노'};
  
final newNctSet = nctSet.map((x) => 'nct $x').toSet();
```

객체 리스트를 class로 매핑하기

```dart
final parsedPeople = people.map((x) => Person(
    // name과 group은 무조건 존재!
	name: x['name']!,
    group: x['group']!,
)).toList();
```

## split()

```dart
String number = '13567';
final parsed = number.split('').map((x) => '$x.jpg').toList();
print(parsed); // [1.jpg, 3.jpg, 5.jpg, 6.jpg, 7.jpg]
```

## where()

조건에 맞는 원소가 아니면 필터링

```dart
List<Map<String, String>> nct = [
    {'name': '태용', 'group': 'nct127'},
    {'name': '윈윈', 'group': 'WayV'},
    {'name': '제노', 'group': 'nct dream'},
    {'name': '재현', 'group': 'nct127'},
`];
  
final nct127 = nct.where((x) => x['group'] == 'nct127');
print(nct127);
```

```dart
final bts = parsedPeople.where((x) => x.group == 'BTS');
```

## reduce() 

prev == 이전 loop의 return값

list의 원소의 type과 동일한 type을 리턴해야함

```dart
List<int> numbers = [1, 3, 5, 7, 9];
final newNumbers = numbers.reduce((prev, next) {
	int result = prev + next;
	print('$prev + $next = $result');
	return result;
});
print(newNumbers);
// 1 + 3 = 4
// 4 + 5 = 9
// 9 + 7 = 16
// 16 + 9 = 25
// 25
```

## fold()

같은 타입 리턴 안해도 됨

```dart
List<int> numbers = [1, 3, 5, 7, 9];
final sum = numbers.fold<int>(0, (prev, next) => prev + next);
print(sum);
```

```dart
List<int> numbers = [1, 3, 5, 7, 9];
final sum = numbers.fold<String>('', (prev, next) {
	print('$prev');
	return '$prev $next ';
});
print(sum);
// 1 
// 1  3 
// 1  3  5 
// 1  3  5  7 
// 1  3  5  7  9 
```

## cascading operator

기존 리스트의 원소를 새로운 리스트에 풀어넣기 

```dart
List<int> odd = [1, 3, 5, 7];
List<int> even = [2, 4, 6, 8];

print([...even, ...odd]); // [2, 4, 6, 8, 1, 3, 5, 7]
```