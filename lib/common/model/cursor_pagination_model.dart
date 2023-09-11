
import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}
// 로딩일 경우
class CursorPaginationLoading extends CursorPaginationBase {}
// 에러일 경우
class CursorPaginationError extends CursorPaginationBase {
  final String message;
  CursorPaginationError({required this.message});
}

// 정상 데이터가 들어올 경우
@JsonSerializable(genericArgumentFactories: true)
class CursorPagination<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  copyWith({CursorPaginationMeta? meta, List<T>? data,}) => CursorPagination(meta: meta ?? this.meta, data: data ?? this.data,);

  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT)
  => _$CursorPaginationFromJson(json, fromJsonT);
}
// 새로고침 일 경우
class CursorPaginationReFetch<T> extends CursorPagination<T> {
  CursorPaginationReFetch({
    required super.meta,
    required super.data,
  });
}
// 추가 데이터를 요청할 경우
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({required this.count, required this.hasMore});

  copyWith({int? count, bool? hasMore}) => CursorPaginationMeta(count: count ?? this.count, hasMore: hasMore ?? this.hasMore);

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) => _$CursorPaginationMetaFromJson(json);
}