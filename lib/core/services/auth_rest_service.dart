import 'package:app_captusiat/core/services/network_service.dart';
import 'package:dio/dio.dart';

class AuthRestService extends NetworkService {
  @override
  final Dio dio;

  AuthRestService(this.dio) {
    dio.options.baseUrl = 'http://localhost:8080/auth/public/Authentication';
    dio.options.headers = {};
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  @override
  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) {
    return dio.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> post<T>(String path, {Map<String, dynamic>? data}) {
    return dio.post(path, data: data);
  }

  @override
  Future<Response<T>> patch<T>(String path,
      {Map<String, dynamic>? queryParameters, Map<String, dynamic>? data}) {
    return dio.patch(
      path,
      queryParameters: queryParameters,
      data: data,
    );
  }
}
