import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class DimensionsModel extends DimensionsEntity {
  const DimensionsModel({
    required super.width,
    required super.height,
    required super.depth,
  });

  factory DimensionsModel.fromJson(Map<String, dynamic> json) =>
      _$DimensionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionsModelToJson(this);
}

@JsonSerializable()
class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.rating,
    required super.comment,
    required super.date,
    required super.reviewerName,
    required super.reviewerEmail,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

class MetaModel extends MetaEntity {
  const MetaModel({
    required super.barcode,
    required super.qrCode,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      barcode: json['barcode'] as String? ?? '',
      qrCode: json['qrCode'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barcode': barcode,
      'qrCode': qrCode,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.tags,
    required super.brand,
    required super.sku,
    required super.weight,
    required DimensionsModel super.dimensions, // Use DimensionsModel here
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required List<ReviewModel> super.reviews, // Use List<ReviewModel> here
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    required MetaModel super.meta, // Use MetaModel here
    required super.images,
    required super.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 0,
      tags: json['tags'] != null
          ? List<String>.from((json['tags'] as List<dynamic>)
              .map((tag) => tag?.toString() ?? ''))
          : <String>[],
      brand: json['brand'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      weight: json['weight'] as int? ?? 0,
      dimensions: json['dimensions'] != null
          ? DimensionsModel.fromJson(json['dimensions'] as Map<String, dynamic>)
          : const DimensionsModel(width: 0, height: 0, depth: 0),
      warrantyInformation: json['warrantyInformation'] as String? ?? '',
      shippingInformation: json['shippingInformation'] as String? ?? '',
      availabilityStatus: json['availabilityStatus'] as String? ?? '',
      reviews: json['reviews'] != null
          ? (json['reviews'] as List<dynamic>)
              .map((reviewJson) =>
                  ReviewModel.fromJson(reviewJson as Map<String, dynamic>))
              .toList()
          : <ReviewModel>[],
      returnPolicy: json['returnPolicy'] as String? ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] as int? ?? 0,
      meta: json['meta'] != null
          ? MetaModel.fromJson(json['meta'] as Map<String, dynamic>)
          : MetaModel(
              barcode: '',
              qrCode: '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
      images: json['images'] != null
          ? List<String>.from((json['images'] as List<dynamic>)
              .map((image) => image?.toString() ?? ''))
          : <String>[],
      thumbnail: json['thumbnail'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      // Ensure the nested models also have toJson methods
      'dimensions': (dimensions as DimensionsModel).toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews':
          reviews.map((review) => (review as ReviewModel).toJson()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': (meta as MetaModel).toJson(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}
