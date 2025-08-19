import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/features/auth/data/models/signin_user_req.dart';
import 'package:ecomerce/features/auth/data/models/signup_model.dart';
import 'package:ecomerce/features/auth/data/models/user.dart';
import 'package:ecomerce/features/auth/data/source/auth_firebase_service.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<DataState> signup(UserCredentialRequestModel userModel) async {
    return await sl<AuthFirebaseService>().signup(userModel);
  }

  @override
  Future<DataState> getAges() async {
    return await sl<AuthFirebaseService>().getAges();
  }

  @override
  Future<DataState> signin(SigninUserReq user) async {
    return await sl<AuthFirebaseService>().signin(user);
  }

  @override
  Future<DataState> sendPasswordResetEmail(String email) async {
    return await sl<AuthFirebaseService>().sendPasswordResetEmail(email);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthFirebaseService>().isLoggedIn();
  }

  @override
  Future<DataState> getUser() async {
    var user = await sl<AuthFirebaseService>().getUser();
    if (user is DataSuccess) {
      try {
        return DataSuccess(UserModel.fromJson(user.data).toEntity());
      } catch (e) {
        return DataError(Exception('Failed to parse user data'));
      }
    } else if (user is DataError) {
      return user;
    } else {
      return DataError(Exception('Unknown error occurred'));
    }
  }
}
