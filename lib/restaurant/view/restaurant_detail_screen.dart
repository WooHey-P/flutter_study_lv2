import 'package:flutter/material.dart';
import 'package:flutter_study_lv2/common/layout/default_layout.dart';
import 'package:flutter_study_lv2/product/component/product_card.dart';
import 'package:flutter_study_lv2/restaurant/component/restaurant_cart.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '레스토랑 상세',
      child: Column(
        children: [
          RestaurantCard(
              image: Image.asset(
                'asset/img/food/ddeok_bok_gi.jpg'
              ),
              name: '불떡',
              tags: ['떡볶이', '치즈', '매운맛'],
              ratingsCount: 1,
              deliveryTime: 1,
              deliveryFee: 1,
              ratings: 1,
              isDetail: true,
              detail: '상세 내용'
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ProductCard(),
          ),
        ],
      ),
    );
  }
}
