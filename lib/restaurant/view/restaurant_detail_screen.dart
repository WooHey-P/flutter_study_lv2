import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study_lv2/common/layout/default_layout.dart';
import 'package:flutter_study_lv2/product/component/product_card.dart';
import 'package:flutter_study_lv2/restaurant/component/restaurant_cart.dart';
import 'package:flutter_study_lv2/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_study_lv2/restaurant/repository/restaurant_repository.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  // 레스토랑 아이디
  final String id;

  const RestaurantDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '레스토랑 상세',
      child: FutureBuilder<RestaurantDetailModel>(
        future: ref.watch(restaurantRepositoryProvider).getRestaurantDetail(id: id),
        builder: (context, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('데이터를 불러오는데 실패했습니다.'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator()
            );
          }

          return CustomScrollView(
            slivers: [
              renderTop(item: snapshot.data!),
              renderLable(),
              renderProducts(products: snapshot.data!.products),
            ],
          );
        },
      )
    );
  }

  SliverToBoxAdapter renderTop({required RestaurantDetailModel item}){
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: item,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLable() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  renderProducts({required List<ProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = products[index];

          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ProductCard.fromModel(
              model: item,
            ),
          );
        },
        childCount: products.length,
      )),
    );
  }
}
