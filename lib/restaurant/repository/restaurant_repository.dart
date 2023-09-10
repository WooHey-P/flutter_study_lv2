
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study_lv2/common/const/data.dart';
import 'package:flutter_study_lv2/common/dio/dio.dart';
import 'package:flutter_study_lv2/common/model/cursor_pagination_model.dart';
import 'package:flutter_study_lv2/common/model/pagination_params.dart';
import 'package:flutter_study_lv2/restaurant/model/restaurant_model.dart';
import 'package:retrofit/http.dart';

import '../model/restaurant_detail_model.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
  return repository;
});

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) = _RestaurantRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    // build time constant 이어야 함
    @Queries() PaginationParams? params = const PaginationParams(),
});

  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}