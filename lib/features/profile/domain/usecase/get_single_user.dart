import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/domain/entity/user_entity.dart';
import 'package:ecomerce/features/profile/domain/repository/user_repo.dart';

class GetSingleUser extends Usecase<DataState<UserEntity>, NoParams> {
  final UserRepo _userRepo;

  GetSingleUser(this._userRepo);

  @override
  Future<DataState<UserEntity>> call(NoParams params) async {
    return await _userRepo.getSingleUser();
  }
}
