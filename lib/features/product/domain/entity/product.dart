import 'package:json_annotation/json_annotation.dart';

class DimensionsEntity {
  final double width;
  final double height;
  final double depth;

  const DimensionsEntity({
    required this.width,
    required this.height,
    required this.depth,
  });
}

class ReviewEntity {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  const ReviewEntity({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });
}

class MetaEntity {
  final String barcode;
  final String qrCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MetaEntity({
    required this.barcode,
    required this.qrCode,
    required this.createdAt,
    required this.updatedAt,
  });
}

class ProductEntity {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'category')
  final String category;
  @JsonKey(name: 'price')
  final double price;
  @JsonKey(name: 'discountPercentage')
  final double discountPercentage;
  @JsonKey(name: 'rating')
  final double rating;
  @JsonKey(name: 'stock')
  final int stock;
  @JsonKey(name: 'tags')
  final List<String> tags;
  @JsonKey(name: 'brand')
  final String brand;
  @JsonKey(name: 'sku')
  final String sku;
  @JsonKey(name: 'weight')
  final int weight;
  @JsonKey(name: 'dimensions')
  final DimensionsEntity dimensions;
  @JsonKey(name: 'warrantyInformation')
  final String warrantyInformation;
  @JsonKey(name: 'shippingInformation')
  final String shippingInformation;
  @JsonKey(name: 'availabilityStatus')
  final String availabilityStatus;
  @JsonKey(name: 'reviews')
  final List<ReviewEntity> reviews;
  @JsonKey(name: 'returnPolicy')
  final String returnPolicy;
  @JsonKey(name: 'minimumOrderQuantity')
  final int minimumOrderQuantity;
  @JsonKey(name: 'meta')
  final MetaEntity meta;
  @JsonKey(name: 'images')
  final List<String> images;
  @JsonKey(name: 'thumbnail')
  final String thumbnail;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });
}

// Define an enum for sizes
enum SizeOption { S, M, L, XL, XXL }
