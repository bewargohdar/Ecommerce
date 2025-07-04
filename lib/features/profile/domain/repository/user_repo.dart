import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/features/auth/domain/entity/user_entity.dart';

abstract class UserRepo {
  Future<DataState<UserEntity>> getSingleUser();
}
