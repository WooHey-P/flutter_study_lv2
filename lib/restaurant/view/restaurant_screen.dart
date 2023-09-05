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

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    // 잘못된 예외처리임!! 지금은 이렇게밖에 처리 못하기때문..
    // 에러인지 아닌지 판단하는 로직이 필요함
    if (data.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        itemCount: data.length,
        itemBuilder: (_, index) {
          final curItem = data[index];

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
