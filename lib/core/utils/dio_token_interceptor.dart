part of 'utils.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final getCredentialsUseCase = getLib.Get.find<GetCredentialsUseCase>();

    final result = await getCredentialsUseCase.call(NoParams());

    result.fold(
      (failure) {},
      (credentials) async {
        if (credentials != null) {
          options.headers['Authorization'] = 'Bearer ${credentials.token}';
        }
      },
    );

    super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      debugPrint('--------errror 401');
      try {
        final authX = getLib.Get.find<AuthController>();

        authX.logout(reason: 'Sesión expirada. Inicia sesión');
      } catch (e) {
        debugPrint('Error encontrando AuthController');
      }
    }
    super.onError(err, handler);
  }
}
