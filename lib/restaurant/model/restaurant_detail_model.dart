import 'package:flutter_study_lv2/restaurant/model/restaurant_model.dart';

import '../../common/const/data.dart';

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<Product> products;
  
  RestaurantDetailModel ({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee, 
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson({
    required Map<String, dynamic> json
  }) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values.firstWhere((element) => element.name == json['priceRange']),
      ratings: json['ratings'].toDouble(),
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      products: List<Product>.from(json['products'].map<Product>((product) => Product.fromJson(json: product))),
    );
  }
}

class Product {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  Product({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory Product.fromJson({required Map<String, dynamic> json}) {
    return Product(
      id: json['id'],
      name: json['name'],
      imgUrl: 'http://$ip${json['imgUrl']},
      detail: json['detail'],
      price: json['price'],
    );
  }
}