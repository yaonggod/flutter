import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}

// 에러난 상태
class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({required this.message});
}

// 로딩 상태 - meta, data 존재 안함
class CursorPaginationLoading extends CursorPaginationBase {}

// 성공적으로 받아온 상태
@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> extends CursorPaginationBase {
  // pagination 정보
  final CursorPaginationMeta meta;

  // data리스트, model은 바뀔 수 있음
  final List<T> data;

  CursorPagination({required this.meta, required this.data});

  CursorPagination copyWith({
    CursorPaginationMeta? meta,
    List<T>? data,
  }) {
    return CursorPagination<T>(meta: meta ?? this.meta, data: data ?? this.data);
  }

  // 입력받을 타입을 어떻게 json에서 model로 변환하는지 알려주기 - T의 fromJson 생성자가 자동으로 들어감
  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({required this.count, required this.hasMore});

  CursorPaginationMeta copyWith({ int? count, bool? hasMore }) {
    return CursorPaginationMeta(count: count ?? this.count, hasMore: hasMore ?? this.hasMore);
  }

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

// 새로고침하는 상태 - meta랑 data가 이미 존재하고 다시 요청 보내서 갱신
// CursorPagination과 CursorPaginationBase를 상속받음
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

// 추가 데이터를 요청할 때 로딩중인 경우
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({required super.meta, required super.data});
}
