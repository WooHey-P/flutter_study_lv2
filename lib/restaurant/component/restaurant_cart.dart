import 'package:flutter/material.dart';
import 'package:flutter_study_lv2/colors.dart';

import '../model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;

  // 레스토랑 이름
  final String name;
  // 태그
  final List<String> tags;
  // 평점 개수
  final int ratingsCount;
  // 배솔 걸리는 시간
  final int deliveryTime;
  // 배송 비용
  final int deliveryFee;
  // 평균 평점
  final double ratings;

  const RestaurantCard(
      {super.key,
      required this.image,
      required this.name,
      required this.tags,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.ratings});

  factory RestaurantCard.fromModel({required RestaurantModel model}) {
    return RestaurantCard (
      image: Image.network(
        model.thumbUrl,
        height: 150,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: image,
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tags.join(' | '),
              style: TextStyle(
                fontSize: 14,
                color: BODY_TEXT_COLOR,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _IconText(
                  icon: Icons.star,
                  label: '$ratings',
                ),
                renderDot(),
                _IconText(
                    icon: Icons.receipt,
                    label: '$ratingsCount',
                ),
                renderDot(),
                _IconText(
                  icon: Icons.timelapse_outlined,
                  label: '$deliveryTime 분',
                ),
                renderDot(),
                _IconText(
                  icon: Icons.monetization_on,
                  // 배달비가 0원이면 무료 배달
                  label: deliveryFee == 0 ? '무료' : '$deliveryFee 원',
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  renderDot(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ' | ',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: PRIMARY_COLOR,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
