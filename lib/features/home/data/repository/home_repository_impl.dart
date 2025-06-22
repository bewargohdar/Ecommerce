import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/error/failure.dart';
import 'package:ecomerce/features/home/data/models/home_model.dart';
import 'package:ecomerce/features/home/domain/entity/home.dart';
import 'package:ecomerce/features/home/domain/repository/home_repository.dart';

import '../source/home_api_service.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApiService homeApiService;

  HomeRepositoryImpl({required this.homeApiService});

  @override
  Future<Either<Failure, HomeEntity>> getHomeData() async {
    try {
      final response = await homeApiService.getProducts();
      final products = response.products;

      if (products == null || products.isEmpty) {
        return Right(HomeModel(topSellingProducts: [], newArrivals: []));
      }

      final forTopSelling = List.of(products);
      forTopSelling.sort(
          (a, b) => b.minimumOrderQuantity.compareTo(a.minimumOrderQuantity));
      final topSelling = forTopSelling.take(5).toList();

      final forNewArrivals = List.of(products);
      forNewArrivals
          .sort((a, b) => b.meta.createdAt.compareTo(a.meta.createdAt));
      final newArrivals = forNewArrivals.take(5).toList();

      return Right(
          HomeModel(topSellingProducts: topSelling, newArrivals: newArrivals));
    } catch (e) {
      // It's also better to create a ServerFailure with a specific message
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
