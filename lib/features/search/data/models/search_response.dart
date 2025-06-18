import 'package:ecomerce/features/product/data/models/product_model.dart';
import 'package:ecomerce/features/search/domain/entity/search_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

@JsonSerializable()
class GeneralSearchResponseModel extends GeneralSearchResponseEntity {
  @JsonKey(name: 'products')
  final List<ProductModel>? products;

  const GeneralSearchResponseModel({
    this.products,
  }) : super(products: products);

  factory GeneralSearchResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralSearchResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralSearchResponseModelToJson(this);
}
