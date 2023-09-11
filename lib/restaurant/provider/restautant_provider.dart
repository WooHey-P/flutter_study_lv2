import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study_lv2/common/model/cursor_pagination_model.dart';
import 'package:flutter_study_lv2/common/model/pagination_params.dart';
import 'package:flutter_study_lv2/restaurant/model/restaurant_model.dart';
import 'package:flutter_study_lv2/restaurant/repository/restaurant_repository.dart';

final restaurantProvider = StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    // RestaurantStateNotifier 가 생성되는 순간에 paginate() 함수를 실행한다.
    // 이렇게 하지 않으면 매번 UI 에서 RestaurantStateNotifier 를 실행 할 때
    // 필요한 함수들이 실행됐는지 확인하면서 로직 짜줘야 하기 때문
    paginate();
  }

  void paginate({
    int fetchCount = 20,
    // 추가로 데이터 더 가져오기
    // true -> 추가로 데이터 더 가져옴
    // false -> 새로고침(현재 상태 덮어씌움), 데이터 유지한 상태에서 새로고침
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true -> CursorPaginationLoading(), 아예 데이터 다 지우고 새로고침
    bool forceReFetch = false,
  }) async {
    try {
      // 5가지 가능성
      // State 의 상태
      // 1. CursorPaginationLoading() -> 데이터가 로딩 중인 상태(캐시 없음)
      // 2. CursorPaginationError() -> 데이터 로딩 실패
      // 3. CursorPagination<RestaurantModel>() -> 데이터 로딩 성공
      // 4. CursorPaginationReFetch<RestaurantModel>() -> 첫 번째 페이지부터 다시 데이터 로딩
      // 5. CursorPaginationFetchingMore<RestaurantModel>() -> 추가 데이터 요청

      // 바로 반환하는 상황
      // 1. hasMore 가 false 일 경우 (기존 상태에서 이미 모든 데이터를 가져온 경우)
      //  - 더이상 데이터를 가져올 필요가 없음
      if (state is CursorPagination && !forceReFetch) {
        final pState = state as CursorPagination;
        if (!pState.meta.hasMore) return;
      }
      // 2. fetchMore 가 true 일 경우 (추가 데이터를 요청하는 경우)
      //  - fetchMore 가 아닐 때, 새로고침의 의도가 있다고 판단
      //  - 중간에 paginate() 함수가 실행되면 그냥 함수 실행
      //  - 데이터를 가져오는 도중에 새로고침 하는 경우도 있기 때문
      final isLoading = state is CursorPaginationLoading;   // 완전 처음
      final isReFetch = state is CursorPaginationReFetch;   // 데이터 있는데 더 가져오려고 할 때
      final isFetchingMore = state is CursorPaginationFetchingMore;
      if (fetchMore && (isLoading || isReFetch || isFetchingMore)) return;

      // paginationParams 생성
      PaginationParams params = PaginationParams(
        count: fetchCount,
      );
      // fetchMore 가 true 면 무조건 데이터가 있음
      // 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination;
        // CursorPaginationFetchingMore 상태로 변경
        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );
        params = params.copyWith(after: pState.data.last.id);
      }
      else {
        // 만약 데이터가 있는 상태에서 새로고침을 하는 경우
        // 기존 데이터를 보존한 채로 fetch (APi 요청를 진행)
        if (state is  CursorPagination && !forceReFetch) {
          final pState = (state as CursorPagination);
          state = CursorPaginationReFetch(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          // 나머지 상황.. 데이터를 유지할 필요가 없음
          state = CursorPaginationLoading();
        }
      }

      // 최신 20개 데이터만 들어있음
      final resp = await repository.paginate(params: params);
      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;
        state = resp.copyWith(
            data: [
              // ... -> 리스트 안에 있는 모든 아이템을 풀어서 넣어줌
              ...pState.data,
              ...resp.data
            ]
        );
      } else {
        // CursorPaginationReFetch, CursorPaginationLoading 인 경우
        // resp -> 맨 처음 데이터
        state = resp;
      }
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 불러오는데 실패했습니다.');
    }
  }
}