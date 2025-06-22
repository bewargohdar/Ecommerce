import 'dart:convert';

import 'package:ecomerce/features/product/data/models/product_model.dart';
import 'package:ecomerce/features/home/domain/entity/home.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class HomeModel extends HomeEntity {
  @override
  final List<ProductModel> topSellingProducts;
  @override
  final List<ProductModel> newArrivals;

  const HomeModel({
    required this.topSellingProducts,
    required this.newArrivals,
  }) : super(
          newArrivals: newArrivals,
          topSellingProducts: topSellingProducts,
        );

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}
