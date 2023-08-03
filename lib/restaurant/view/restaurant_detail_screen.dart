import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_lv2/common/layout/default_layout.dart';
import 'package:flutter_study_lv2/product/component/product_card.dart';
import 'package:flutter_study_lv2/restaurant/component/restaurant_cart.dart';
import 'package:flutter_study_lv2/restaurant/model/restaurant_detail_model.dart';

import '../../common/const/data.dart';

class RestaurantDetailScreen extends StatelessWidget {
  // 레스토랑 아이디
  final String id;

  const RestaurantDetailScreen({super.key, required this.id});

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get('http://$ip/restaurant/$id', options: Options(
      headers: {
        'authorization': 'Bearer $accessToken'
      }
    ));
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '레스토랑 상세',
      child: FutureBuilder<Map<String, dynamic>>(
        future: getRestaurantDetail(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator()
            );
          }

          final item = RestaurantDetailModel.fromJson(json: snapshot.data!);

          return CustomScrollView(
            slivers: [
              renderTop(item: item),
              renderLable(),
              renderProducts(products: item.products),
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

  renderProducts({required List<Product> products}) {
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
