import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/features/profile/domain/entity/user.dart';

abstract class ProfileRepo {
  Future<DataState<UserEntity>> getSingleUser(int id);
}
