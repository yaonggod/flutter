# jsonSerializable

model을 만들 때 기본 생성자랑 factory 생성자로 fromJson 생성자를 만들었음

```dart
ProductModel(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.detail,
      required this.price});
```

```dart
factory ProductModel.fromJson({required Map<String, dynamic> json}) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        imgUrl: "http://$ip${json['imgUrl']}",
        detail: json['detail'],
        price: json['price']);
  }
```

그런데 json의 요소 하나하나마다 매핑하기 매우 귀찮음

pubspec.yaml에

```yaml
dependencies:
	json_annotation

dev_dependencies:
	json_serializable
	build_runner
```

json_annotation은 pub add, json_serializable과 build_runner는 pub add dev 함

dependencies는 앱과 같이 packaging되는거, dev_dependencies는 개발할 때, build할때만 필요한거 

## 1. model을 jsonSerializable로 만들기

```dart
@JsonSerializable()
class ProductModel {
    // 기본 생성자 선언
    // fromJson 생성자 선언
}
```

## 2. jsonSerializable 파일 만들기

```dart
part 'product_model.g.dart';
```

## 3. fromJson 생성자 선언

```dart
factory ProductModel.fromJson(Map<String, dynamic> json)
    => _$ProductModelFromJson(json);
```

## 4. build_runner run하기

```bash
flutter pub run build_runner build -> 일회성 빌드
flutter pub run build_runner watch -> 변화 확인 시 재빌드
```

## @. toJson()

역으로 model을 json으로 만들기

```dart
Map<String, dynamic> toJson() => _$ProductModelToJson(this);
```

## @. JsonKey()

fromJson하거나 toJson할때 사용할 함수를 static으로 만들어서 적용하기

```dart
@JsonKey(
	fromJson: pathToUrl,
)
final String imgUrl;
```

```dart
static pathToUrl(String path) {
    return "http://$ip$path";
}
```

imgUrl을 알아서 pathToUrl에 넣어서 리턴하고 이를 모델 인스턴스에 넣는