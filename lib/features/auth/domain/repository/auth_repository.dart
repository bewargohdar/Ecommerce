import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/auth/data/models/signin_model.dart';

abstract class AuthRepository {
  Future<Either> signup(UserCredentialRequestModel userModel);
  Future<Either> getAges();
}
