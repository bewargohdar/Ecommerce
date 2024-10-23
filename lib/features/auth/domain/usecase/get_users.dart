import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';

import '../../../../service_locator.dart';

class GetUsers implements Usecase<Either, dynamic> {
  @override
  Future<Either> call(dynamic params) async {
    return await sl<AuthRepository>().getUser();
  }
}
