import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/product/data/source/product_api_service.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:ecomerce/features/product/domain/repository/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApiService _productApiService;

  ProductRepositoryImpl(this._productApiService);

  @override
  Future<Either<String, List<ProductEntity>>> getProductsByCategory(
      String categorySlug) async {
    final result = await _productApiService.getProductsByCategory(categorySlug);

    return result.fold(
      (failure) => Left(failure),
      (productModels) {
        // Convert ProductModel list to ProductEntity list
        final productEntities = productModels.map<ProductEntity>((model) {
          return ProductEntity(
            id: model.id,
            title: model.title,
            description: model.description,
            category: model.category,
            price: model.price,
            discountPercentage: model.discountPercentage,
            rating: model.rating,
            stock: model.stock,
            tags: model.tags,
            brand: model.brand,
            sku: model.sku,
            weight: model.weight,
            dimensions: model.dimensions,
            warrantyInformation: model.warrantyInformation,
            shippingInformation: model.shippingInformation,
            availabilityStatus: model.availabilityStatus,
            reviews: model.reviews,
            returnPolicy: model.returnPolicy,
            minimumOrderQuantity: model.minimumOrderQuantity,
            meta: model.meta,
            images: model.images,
            thumbnail: model.thumbnail,
          );
        }).toList();
        return Right(productEntities);
      },
    );
  }
}
