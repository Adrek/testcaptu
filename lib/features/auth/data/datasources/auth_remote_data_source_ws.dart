import 'package:app_captusiat/core/services/network_service.dart';
import 'package:app_captusiat/core/utils/utils.dart';
import 'package:app_captusiat/features/auth/domain/entities/user_credentials.dart';

class AuthRemoteDataSourceWS {
  final NetworkService _networkService;

  AuthRemoteDataSourceWS(this._networkService);

  Future<UserCredentials?> login(String username, String password) async {
    try {
      final resp = await _networkService.dio.post(
        '/login',
        data: {
          "usuario": username,
          "contrasena": password,
        },
      );

      final data = resp.data;

      if (resp.data['token'] != null) {
        return UserCredentials(
          id: data['icodUsu'],
          username: username,
          token: data['token']['access_token'],
          refreshToken: data['token']['refresh_token'],
        );
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
