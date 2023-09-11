import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final String? after;
  final int? count;

  const PaginationParams({
    this.after,
    this.count,
  });

  // copyWith
  PaginationParams copyWith({
    String? after,
    int? count,
  }) => PaginationParams(
    count: count ?? this.count,
    after: after ?? this.after,
  );

  factory PaginationParams.fromJson(Map<String, dynamic> json) => _$PaginationParamsFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}