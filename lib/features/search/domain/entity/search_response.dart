import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:json_annotation/json_annotation.dart';

class GeneralSearchResponseEntity {
  @JsonKey(name: 'products')
  final List<ProductEntity>? products;

  const GeneralSearchResponseEntity({this.products});
}
