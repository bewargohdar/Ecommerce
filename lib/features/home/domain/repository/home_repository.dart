import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/home.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeEntity>> getHomeData();
}
