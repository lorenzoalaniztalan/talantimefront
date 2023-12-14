import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HttpClientSetup {
  HttpClientSetup(String baseUrl) {
    apiClient.options.baseUrl = baseUrl;
  }
  String? token;
  final apiClient = Dio();
  final storage = const FlutterSecureStorage();

  Future<Dio> initializeClient() async {
    await _retrieveToken();
    _addInterceptor();
    return apiClient;
  }

  Future<void> storeToken(String? value) async {
    await storage.write(key: 'token', value: value);
    await _retrieveToken();
    _addInterceptor();
  }

  Future<void> _retrieveToken() async {
    final resToken = await storage.read(key: 'token');
    token = resToken;
  }

  void _addInterceptor() {
    apiClient.interceptors.clear();
    apiClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token.runtimeType == String) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['Content-Type'] = Headers.jsonContentType;
          options.receiveDataWhenStatusError = true;
          options.headers['Accept'] = '*/*';
          return handler.next(options);
        },
        onError: (e, handler) async {
          // TODO: Implement logging and handle refresh token.
          // if (e.response?.statusCode == 401) {
          //   // If a 401 response is received, refresh the access token
          //   final String newAccessToken = await refreshToken();

          //   // Update the request header with the new access token
          //   e.requestOptions.headers['Authorization'] =
          //       'Bearer $newAccessToken';

          //   // Repeat the request with the updated header
          //   return handler.resolve(await dio.fetch(e.requestOptions));
          // }
          return handler.next(e);
        },
      ),
    );
  }
}
