import 'dart:typed_data';

import 'package:common_models_repository/common_models_repository.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:user_api/user_api.dart';

/// {@template http_user_api}
/// A Flutter implementation of the user_api with dio
/// {@endtemplate}
class HttpUserApi extends UserApi {
  /// {@macro http_user_api}
  HttpUserApi(Dio apiClient) {
    _apiClient = apiClient;
    _route = 'users';
  }
  late Dio _apiClient;
  late String _route;

  @override
  Future<User?> getUser() async {
    final res = await _apiClient.get<JsonMap>('/$_route/current_user');
    return User.fromJson(res.data!['data'] as JsonMap);
  }

  @override
  Future<List<User>> getUsers() async {
    final res = await _apiClient.get<dynamic>('/$_route/');
    return (res.data as List<dynamic>)
        .map((e) => User.fromJson(e as JsonMap))
        .toList();
  }

  @override
  Future<String> getAvatar(int userId) async {
    final res = await _apiClient.get<JsonMap>('/$_route/$userId/avatar');
    return res.data!['base64_image'] as String;
  }

  @override
  Future<void> setAvatar(
    Uint8List binary,
    String mimeType,
  ) async {
    final file = MultipartFile.fromBytes(
      binary,
      filename: 'file',
      contentType: MediaType.parse(mimeType),
    );
    final formData = FormData.fromMap({
      'file': file,
    });
    await _apiClient.post<dynamic>('/$_route/avatar', data: formData);
  }

  @override
  Future<void> removeAvatar() async {
    await _apiClient.delete<dynamic>('/$_route/avatar');
  }
}
