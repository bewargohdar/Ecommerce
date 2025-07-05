import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/profile/domain/entity/user.dart';
import 'package:ecomerce/features/profile/domain/repository/profile_repo.dart';

class GetSingleUser extends Usecase<DataState<UserEntity>, int> {
  final ProfileRepo _profileRepo;

  GetSingleUser(this._profileRepo);

  @override
  Future<DataState<UserEntity>> call(int params) async {
    return await _profileRepo.getSingleUser(params);
  }
}
