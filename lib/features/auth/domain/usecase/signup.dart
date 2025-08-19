import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/data/models/signup_model.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/service_locator.dart';

import '../../../../core/resource/data_state.dart';

class SignupUsecase implements Usecase<DataState, UserCredentialRequestModel> {
  @override
  Future<DataState> call(UserCredentialRequestModel? params) async {
    return await sl<AuthRepository>().signup(params!);
  }
}
