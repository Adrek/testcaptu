import 'package:app_captusiat/core/routes/app_pages.dart';
import 'package:app_captusiat/core/utils/use_case.dart';
import 'package:app_captusiat/features/auth/domain/entities/user_credentials.dart';
import 'package:app_captusiat/features/auth/domain/usecases/get_credentials_usecase.dart';
import 'package:app_captusiat/features/auth/domain/usecases/login_usecase.dart';
import 'package:app_captusiat/features/auth/domain/usecases/logout_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final GetCredentialsUseCase getCredentialsUseCase;
  final LogoutUseCase logoutUseCase;

  AuthController({
    required this.loginUseCase,
    required this.getCredentialsUseCase,
    required this.logoutUseCase,
  });

  UserCredentials? _userCredentials;
  UserCredentials? get userCredentials => _userCredentials;

  final isLoading = false.obs;
  final loginError = RxnString();

  Future<void> login(String username, String password) async {
    loginError.value = null;

    isLoading(true);

    final result = await loginUseCase.call(
      LoginParams(username, password),
    );

    result.fold(
      (failure) => {loginError('Error al intentar iniciar sesión')},
      (success) => handleSession(),
    );
    isLoading(false);
  }

  Future<void> handleSession() async {
    isLoading(true);
    final result = await getCredentialsUseCase.call(NoParams());

    result.fold(
      (failure) {
        _userCredentials = null;
        loginError('Login failed, incorrect username or password');
      },
      (credentials) async {
        if (credentials != null) {
          _userCredentials = credentials;
          Get.offAllNamed(AppRoutes.TURNO);
        } else {
          _userCredentials = null;
          Get.offAllNamed(AppRoutes.LOGIN);
        }
      },
    );
    isLoading(false);
  }

  Future<void> logout({String? reason}) async {
    isLoading(true);
    loginError.value = reason;
    final result = await logoutUseCase.call(NoParams());

    result.fold(
      (failure) => {throw UnimplementedError('Error en logout')},
      (success) => {handleSession()},
    );
    isLoading(false);
  }
}
