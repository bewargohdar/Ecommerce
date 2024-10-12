import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/service_locator.dart';

class IsLoggedInUseCase implements Usecase<bool, dynamic> {
  @override
  Future<bool> call(dynamic params) async {
    return await sl<AuthRepository>().isLoggedIn();
  }
}
