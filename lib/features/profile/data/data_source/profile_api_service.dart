import 'package:dio/dio.dart';
import 'package:ecomerce/core/constant/const.dart';
import 'package:ecomerce/core/resource/data_state.dart';

import '../model/user_model.dart';

class ProfileApiService {
  final Dio _dio;
  ProfileApiService(this._dio);

  Future<DataState<UserModel>> fetchSingleUser(int id) async {
    try {
      final response = await _dio.get('$baseUrl/users/$id');

      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(response.data);
        return DataSuccess(userModel);
      } else {
        return DataFailed(
            Exception('Failed to fetch user: ${response.statusCode}'));
      }
    } catch (e) {
      return DataFailed(Exception('Network error: ${e.toString()}'));
    }
  }
}
