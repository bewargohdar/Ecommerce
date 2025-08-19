import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/service_locator.dart';

class GetAgesUseCase implements Usecase<DataState, dynamic> {
  @override
  Future<DataState> call(params) async {
    return await sl<AuthRepository>().getAges();
  }
}
