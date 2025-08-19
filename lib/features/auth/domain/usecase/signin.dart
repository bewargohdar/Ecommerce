import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/data/models/signin_user_req.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/service_locator.dart';

class SigninUsecase implements Usecase<DataState, SigninUserReq> {
  @override
  Future<DataState> call(SigninUserReq? params) async {
    return await sl<AuthRepository>().signin(params!);
  }
}
