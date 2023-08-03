import 'package:flutter/material.dart';
import 'package:flutter_study_lv2/colors.dart';

import '../../restaurant/model/restaurant_detail_model.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final Image image;
  final String detail;
  final int price;

  const ProductCard({super.key, required this.name, required this.image, required this.detail, required this.price});

  factory ProductCard.fromModel({
    required Product model,
  }) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        // 이미지를 꽉 채우기 위해 사용
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    // IntrinsicHeight: 자식 위젯의 높이를 꽉 채우는 위젯
    // IntrinsicWidth: 자식 위젯의 너비를 꽉 채우는 위젯
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: this.image,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              // Column의 크기를 꽉 채우기 위해 사용
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  this.detail,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${this.price}원',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 14,
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
