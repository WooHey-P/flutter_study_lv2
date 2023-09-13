import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study_lv2/restaurant/component/restaurant_cart.dart';
import 'package:flutter_study_lv2/restaurant/provider/restautant_provider.dart';
import 'package:flutter_study_lv2/restaurant/view/restaurant_detail_screen.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../model/restaurant_model.dart';
import '../repository/restaurant_repository.dart';

// 리스트의 마지막 아이템 직전의 상태를 알기 위해 StatefulWidget 으로 변경함
// ScrollController 를 사용하기 위해서임
class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _scrollController 의 특정 값이 변경될 때마다 호출되는 함수
    _controller.addListener(scrollListener);
  }

  void scrollListener() {
    // 현재 위치가 최대 길이보다 조금 덜되는 위치까지 왔다면
    // 새로운 데이터를 추가 요청
    // 바닥에서부터 300 픽셀 위의 스크롤을 넘게되면 실행할 것임
    if (_controller.offset > _controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(
        fetchMore: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final resp = ref.watch(restaurantProvider);

    // 잘못된 예외처리임!! 지금은 이렇게밖에 처리 못하기때문..
    // 에러인지 아닌지 판단하는 로직이 필요함
    switch (resp.runtimeType) {
      // 첫 로딩일 때
      case CursorPaginationLoading:
        return Center(
          child: CircularProgressIndicator(),
        );
      // 에러일 때
      case CursorPaginationError:
        return Center(
          child: Text('데이터를 불러오는데 실패했습니다.'),
        );
    }

    final cp = resp as CursorPagination;
    if (resp.runtimeType is CursorPaginationFetchingMore) {

    } else if (resp.runtimeType is CursorPaginationReFetch) {

    } else {

    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: _controller,

        itemCount: cp.data.length + 1,
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: resp is CursorPaginationFetchingMore ?
                  CircularProgressIndicator() : null,
              ),
            );
          }

          final curItem = cp.data[index];

          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RestaurantDetailScreen(id: curItem.id),
                  ),
                );
              },
              child: RestaurantCard.fromModel(
                model: curItem,
              ));
        },
        separatorBuilder: (_, index) => const SizedBox(height: 16),
      ),
    );
  }
}
