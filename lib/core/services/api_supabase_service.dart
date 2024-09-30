import 'package:app_captusiat/core/services/network_service.dart';
import 'package:dio/dio.dart';

class SupabaseApiService extends NetworkService {
  @override
  final Dio dio;

  SupabaseApiService(this.dio) {
    dio.options.baseUrl = 'https://uebxqtszmwwagcvrdqoy.supabase.co/rest/v1';
    dio.options.headers = {
      "apikey":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVlYnhxdHN6bXd3YWdjdnJkcW95Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjU5OTg1OTUsImV4cCI6MjA0MTU3NDU5NX0.q0_e6dV2isH93nTETJX1QjjFXTgOwgxaxNCVpIXEfLQ",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVlYnhxdHN6bXd3YWdjdnJkcW95Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjU5OTg1OTUsImV4cCI6MjA0MTU3NDU5NX0.q0_e6dV2isH93nTETJX1QjjFXTgOwgxaxNCVpIXEfLQ",
    };
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