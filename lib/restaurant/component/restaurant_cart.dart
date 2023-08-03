import 'package:flutter/material.dart';
import 'package:flutter_study_lv2/colors.dart';
import 'package:flutter_study_lv2/restaurant/model/restaurant_detail_model.dart';

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
  // 디테일 화면인지
  final bool isDetail;
  // 상세 내용
  final String? detail;


  const RestaurantCard(
      {super.key,
      required this.image,
      required this.name,
      required this.tags,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.ratings,
      this.isDetail = false,
      this.detail,
      }
);

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
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
      isDetail: isDetail,
      detail: model is RestaurantDetailModel ? model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDetail)
          image,
        if (!isDetail)
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: image,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16 : 0),
          child: Column(
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
              ),
              if (detail != null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(detail!),
                ),
            ],
          ),
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
