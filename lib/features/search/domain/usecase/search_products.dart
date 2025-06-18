import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/search/domain/entity/search_response.dart';
import 'package:ecomerce/features/search/domain/repository/search_repo.dart';

class SearchProductsUseCase
    extends Usecase<Either<String, GeneralSearchResponseEntity>, String> {
  final SearchRepository searchRepository;

  SearchProductsUseCase(this.searchRepository);

  @override
  Future<Either<String, GeneralSearchResponseEntity>> call({String? params}) {
    return searchRepository.searchProducts(params!);
  }
}
