import 'package:json_annotation/json_annotation.dart';
import 'package:project06/restaurant/model/restaurant_model.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> {
  // pagination 정보
  final CursorPaginationMeta meta;
  // data리스트, model은 바뀔 수 있음
  final List<T> data;

  CursorPagination({ required this.meta, required this.data });

  // 입력받을 타입을 어떻게 json에서 model로 변환하는지 알려주기 - T의 fromJson 생성자가 자동으로 들어감
  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT)
  => _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({ required this.count, required this.hasMore });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json)
  => _$CursorPaginationMetaFromJson(json);
}



