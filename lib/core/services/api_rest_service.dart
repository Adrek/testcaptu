import 'package:app_captusiat/core/services/network_service.dart';
import 'package:dio/dio.dart';

class ApiRestService extends NetworkService {
  @override
  final Dio dio;

  ApiRestService(this.dio) {
    dio.options.baseUrl = 'http://172.29.170.120:8080/api/v1/captudep';
    dio.options.headers = {};
    // dio.interceptors.add(LogInterceptor(responseBody: true));
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

/*
// Función que convierte un request en formato curl
void printCurlRequest(RequestOptions options) {
  final method = options.method.toUpperCase();
  final headers =
      options.headers.map((key, value) => MapEntry(key, value.toString()));
  final data = options.data != null ? options.data.toString() : '';

  final curlCommand =
      StringBuffer('curl -X $method \'${options.uri.toString()}\'');

  // Agregar headers al comando curl
  headers.forEach((key, value) {
    curlCommand.write(' -H "$key: $value"');
  });

  // Agregar data si existe
  if (data.isNotEmpty) {
    curlCommand.write(' --data \'$data\'');
  }

  // Imprimir el comando curl en la consola
  debugPrint('CURL Format: ${curlCommand.toString()}');
}
 */