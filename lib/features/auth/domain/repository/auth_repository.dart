import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/features/auth/data/models/signin_user_req.dart';
import 'package:ecomerce/features/auth/data/models/signup_model.dart';

abstract class AuthRepository {
  Future<DataState> signup(UserCredentialRequestModel userModel);
  Future<DataState> getAges();
  Future<DataState> signin(SigninUserReq userModel);
  Future<DataState> sendPasswordResetEmail(String email);
  Future<bool> isLoggedIn();
  Future<DataState> getUser();
}
