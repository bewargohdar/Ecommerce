import 'package:ecomerce/features/category/domain/entity/category.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.slug, required super.name, required super.url});

  CategoryModel.fromJson(Map<String, dynamic> json)
      : super(
          slug: json['slug']?.toString() ?? '',
          name: json['name']?.toString() ?? '',
          url: json['url']?.toString() ?? '',
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
