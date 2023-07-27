import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_lv2/restaurant/component/restaurant_cart.dart';

import '../../common/const/data.dart';
import '../model/restaurant_model.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get('http://$ip/restaurant',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      ),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List>(
              future: paginateRestaurant(),
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    final pItem = RestaurantModel.fromJson(snapshot.data![index]);

                    return RestauantCard(
                      image: Image.network(
                        pItem.thumbUrl,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      name: pItem.name,
                      tags: pItem.tags,
                      ratingsCount: pItem.ratingsCount,
                      deliveryTime: pItem.deliveryTime,
                      deliveryFee: pItem.deliveryFee,
                      ratings: pItem.ratings,
                    );
                  },
                  separatorBuilder: (_, index) => const SizedBox(height: 16),
                );
              },
            ),
          ),
        ));
  }
}
