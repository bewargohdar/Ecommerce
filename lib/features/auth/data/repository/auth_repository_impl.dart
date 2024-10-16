import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/auth/data/models/signin_user_req.dart';
import 'package:ecomerce/features/auth/data/models/signup_model.dart';
import 'package:ecomerce/features/auth/data/models/user.dart';
import 'package:ecomerce/features/auth/data/source/auth_firebase_service.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  late final AuthFirebaseService authFirebaseService;
  @override
  Future<Either> signup(UserCredentialRequestModel userModel) async {
    return await sl<AuthFirebaseService>().signup(userModel);
  }

  @override
  Future<Either> getAges() {
    return sl<AuthFirebaseService>().getAges();
  }

  @override
  Future<Either> signin(SigninUserReq userModel) async {
    return await sl<AuthFirebaseService>().signin(userModel);
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    return await sl<AuthFirebaseService>().sendPasswordResetEmail(email);
  }

  @override
  Future<bool> isLoggedIn() async {
    return sl<AuthFirebaseService>().isLoggedIn();
  }

  @override
  Future<Either> getUser() async {
    var user = await sl<AuthFirebaseService>().getUser();
    return user.fold((error) {
      return Left(error);
    }, (data) {
      return Right(UserModel.fromJson(data).toEntity());
    });
  }
}
