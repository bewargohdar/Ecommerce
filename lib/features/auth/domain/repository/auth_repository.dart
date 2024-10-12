import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/auth/data/models/signin_user_req.dart';
import 'package:ecomerce/features/auth/data/models/signup_model.dart';

abstract class AuthRepository {
  Future<Either> signup(UserCredentialRequestModel userModel);
  Future<Either> getAges();
  Future<Either> signin(SigninUserReq userModel);
  Future<Either> sendPasswordResetEmail(String email);
  Future<bool> isLoggedIn();
}
