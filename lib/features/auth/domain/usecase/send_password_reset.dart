import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/service_locator.dart';

class SendPasswordResetEmailUseCase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<AuthRepository>().sendPasswordResetEmail(params!);
  }
}
