import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    /* final token = await Get.find<SecureStorageService>().getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    } */
    super.onRequest(options, handler);
  }
}
