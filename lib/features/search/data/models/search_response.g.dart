// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralSearchResponseModel _$GeneralSearchResponseModelFromJson(
        Map<String, dynamic> json) =>
    GeneralSearchResponseModel(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeneralSearchResponseModelToJson(
        GeneralSearchResponseModel instance) =>
    <String, dynamic>{
      'products': instance.products,
    };
