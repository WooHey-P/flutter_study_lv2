import 'package:flutter/material.dart';
import 'package:flutter_study_lv2/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    // IntrinsicHeight: 자식 위젯의 높이를 꽉 채우는 위젯
    // IntrinsicWidth: 자식 위젯의 너비를 꽉 채우는 위젯
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              width: 110,
              height: 110,
              // 이미지를 꽉 채우기 위해 사용
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              // Column의 크기를 꽉 채우기 위해 사용
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '떢뽂이',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '전통 떡볶이! !',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '가격',
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
