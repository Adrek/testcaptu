import 'package:dio/dio.dart';

abstract class NetworkService {
  Dio get dio;

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters});
  Future<Response<T>> post<T>(String path, {Map<String, dynamic>? data});
  Future<Response<T>> patch<T>(String path,
      {Map<String, dynamic>? queryParameters, Map<String, dynamic>? data});
}
