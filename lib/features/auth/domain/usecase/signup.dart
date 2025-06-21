import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/data/models/signup_model.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/service_locator.dart';

class SignupUsecase implements Usecase<Either, UserCredentialRequestModel> {
  @override
  Future<Either> call(UserCredentialRequestModel? params) async {
    return await sl<AuthRepository>().signup(params!);
  }
}
