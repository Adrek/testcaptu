part of 'utils.dart';

class AnalyzeInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('*** Request ***');
    debugPrint('Method: ${options.method}');
    debugPrint('URL: ${options.path}');
    debugPrint('Headers: ${options.headers}');
    if (options.data != null) {
      debugPrint('Data: ${options.data}');
    }
    debugPrint('Query Parameters: ${options.queryParameters}');
    super.onRequest(options, handler); // continúa con el siguiente interceptor
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('*** Response ***');
    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Data: ${response.data}');
    super
        .onResponse(response, handler); // continúa con el siguiente interceptor
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('*** Error ***');
    debugPrint('Message: ${err.message}');
    if (err.response != null) {
      debugPrint('Status Code: ${err.response?.statusCode}');
      debugPrint('Data: ${err.response?.data}');
    }
    super.onError(err, handler); // continúa con el siguiente interceptor
  }
}
