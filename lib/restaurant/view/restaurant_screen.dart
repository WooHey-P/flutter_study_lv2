import 'package:flutter/cupertino.dart';
import 'package:flutter_study_lv2/restaurant/component/restaurant_cart.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RestauantCard(
              image: Image.asset(
                'asset/img/food/ddeok_bok_gi.jpg',
                fit: BoxFit.cover
              ),
              name: '불타는 떡볶이',
              tags: ['떡볶이', '치즈', '매운맛'],
              ratingCount: 1,
              deliveryTime: 1,
              deliveryFee: 1,
              averageRating: 1,
      ),
          ),
    ));
  }
}
