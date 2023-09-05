import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study_lv2/restaurant/model/restaurant_model.dart';
import 'package:flutter_study_lv2/restaurant/repository/restaurant_repository.dart';

final restaurantProvider = StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super([]) {
    // RestaurantStateNotifier 가 생성되는 순간에 paginate() 함수를 실행한다.
    // 이렇게 하지 않으면 매번 UI 에서 RestaurantStateNotifier 를 실행 할 때
    // 필요한 함수들이 실행됐는지 확인하면서 로직 짜줘야 하기 때문
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();

    state = resp.data;
  }
}