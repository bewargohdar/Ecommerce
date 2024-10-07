import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/auth/data/models/signin_model.dart';
import 'package:ecomerce/features/auth/data/source/auth_firebase_service.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  late final AuthFirebaseService authFirebaseService;
  @override
  Future<Either> signup(SigninModel userModel) async {
    return await sl<AuthFirebaseService>().signup(userModel);
  }
}
