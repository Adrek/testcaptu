import 'package:app_captusiat/core/services/local_storage_service.dart';
import 'package:app_captusiat/features/auth/domain/entities/user_credentials.dart';

class AuthLocalDataSource {
  final LocalStorageService localStorageService;

  AuthLocalDataSource(this.localStorageService);

  Future<void> saveUserCredentials(UserCredentials credentials) async {
    await localStorageService.saveUserCredentials(credentials.toJsonString());
  }

  Future<UserCredentials?> getUserCredentials() async {
    final credentialsString = await localStorageService.getUserCredentials();

    return credentialsString != null
        ? UserCredentials.fromJsonString(credentialsString)
        : null;
  }

  Future<void> clearUserCredentials() async {
    await localStorageService.clearUserCredentials();
  }
}
