import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/product/data/source/product_api_service.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:ecomerce/features/search/domain/repository/search_repo.dart';

class SearchRepositoryImpl implements SearchRepository {
  final ProductApiService _productApiService;

  SearchRepositoryImpl(this._productApiService);

  @override
  Future<Either<String, List<ProductEntity>>> searchProducts(
      String query) async {
    final result = await _productApiService.getAllProducts();

    return result.fold(
      (failure) => Left(failure),
      (productModels) {
        final filteredProducts = productModels
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()))
            .map<ProductEntity>((model) => ProductEntity(
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
                ))
            .toList();

        return Right(filteredProducts);
      },
    );
  }
}
