import 'package:app_captusiat/core/services/network_service.dart';
import 'package:app_captusiat/core/utils/utils.dart';
import 'package:app_captusiat/features/auth/domain/entities/user_credentials.dart';

class AuthRemoteDataSourceWS {
  final NetworkService _networkService;

  AuthRemoteDataSourceWS(this._networkService);

  Future<UserCredentials?> login(String username, String password) async {
    try {
      await _networkService.dio.get('/ListadoCanal/2');

      /* final users = List<UserSupabaseModel>.from(
          response.data.map((x) => UserSupabaseModel.fromJson(x)));

      final user = users.firstWhereOrNull(
          (e) => e.username == username && e.password == password);

      if (user != null) {
        return UserMapper.fromUserSupbaseModel(user);
      } else {
        return null;
      } */

      return UserCredentials(
        id: 1,
        username: 'agonzalez',
        token: 'eA34sk234dsklSDdskl3dsf',
        refreshToken: 'eA34sk23',
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
