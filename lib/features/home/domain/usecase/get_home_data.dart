import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/home.dart';
import '../repository/home_repository.dart';

class GetHomeData implements Usecase<Either<Failure, HomeEntity>, NoParams> {
  final HomeRepository repository;

  GetHomeData({required this.repository});
  @override
  Future<Either<Failure, HomeEntity>> call(NoParams params) {
    return repository.getHomeData();
  }
}
