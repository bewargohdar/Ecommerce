import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/data/models/signin_user_req.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/service_locator.dart';

class SigninUsecase implements Usecase<Either, SigninUserReq> {
  @override
  Future<Either> call(SigninUserReq params) async {
    return await sl<AuthRepository>().signin(params);
  }
}
