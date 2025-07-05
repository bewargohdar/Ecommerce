import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/features/profile/data/data_source/profile_api_service.dart';
import 'package:ecomerce/features/profile/domain/repository/profile_repo.dart';

import '../model/user_model.dart';

class ProfileRepositoryImpl extends ProfileRepo {
  final ProfileApiService _profileApiService;

  ProfileRepositoryImpl(this._profileApiService);
  @override
  Future<DataState<UserModel>> getSingleUser(int id) {
    return _profileApiService.fetchSingleUser(id);
  }
}
