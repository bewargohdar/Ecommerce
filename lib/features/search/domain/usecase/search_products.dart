import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:ecomerce/features/search/domain/repository/search_repo.dart';

class SearchProductsUseCase
    extends Usecase<Either<String, List<ProductEntity>>, String> {
  final SearchRepository searchRepository;

  SearchProductsUseCase(this.searchRepository);

  @override
  Future<Either<String, List<ProductEntity>>> call({String? params}) {
    return searchRepository.searchProducts(params!);
  }
}
