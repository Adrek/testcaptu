import 'package:app_captusiat/core/services/network_service.dart';
import 'package:app_captusiat/core/utils/utils.dart';
import 'package:app_captusiat/features/auth/data/mapper/user_mapper.dart';
import 'package:app_captusiat/features/auth/data/models/user_supabase_model.dart';
import 'package:app_captusiat/features/auth/domain/entities/user_credentials.dart';
import 'package:get/get.dart';

class AuthRemoteDataSourceSupabase {
  final NetworkService _networkService;

  AuthRemoteDataSourceSupabase(this._networkService);

  Future<UserCredentials?> login(String username, String password) async {
    try {
      final response =
          await _networkService.dio.get('/usuarios', queryParameters: {
        "select": "*",
        "username": "eq.$username",
        "password": "eq.$password",
      });

      final users = List<UserSupabaseModel>.from(
          response.data.map((x) => UserSupabaseModel.fromJson(x)));

      final user = users.firstWhereOrNull(
          (e) => e.username == username && e.password == password);

      if (user != null) {
        return UserMapper.fromUserSupbaseModel(user);
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
