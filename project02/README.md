# flutter

```bash
flutter create project_name
```

## 앱 시작하기

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}
```

## 위젯

UI의 컴포넌트 단위

모든 위젯은 클래스이며, app은 위젯이 중첩되어서 만들어짐

### 예시

root 위젯이 위젯의 한 종류 `StatelessWidget`(정적 위젯, 화면만 구현)을 상속받음

```dart
class App extends StatelessWidget {
    
}
```

모든 root 위젯은 `build` 메소드를 구현해야함 

`build` 메소드는 `MaterialApp`(구글)이나 `CupertinoApp`(ios) 둘 중 하나를 리턴해야함

`appBar`(header같은거), `body`를 가진 `Scaffold`(화면 구성, 구조)를 만드는데, 그 `Scaffold` 안에는 자식 위젯(`Text`위젯)을 가운데 정렬하는 `Center` 위젯이 있음

```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Hello flutter')),
        ),
        body: Center(child: Text('Hello World')),
      ),
    );
  }
}
```

모든 위젯은 required argument가 있고 아닌 argument가 있음, `Text` 위젯은 `String data`가 required임
