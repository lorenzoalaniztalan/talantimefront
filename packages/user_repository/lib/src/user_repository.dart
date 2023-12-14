import 'dart:convert';
import 'dart:typed_data';

import 'package:user_api/user_api.dart';

/// {@template user_repository}
/// Dart package which manages the user domain.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository({
    required UserApi userApi,
  }) : _userApi = userApi;

  final UserApi _userApi;
  User? _user;

  /// Retrieves the currently authenticated user
  Future<User?> getUser() async {
    if (_user != null) return _user;
    final res = await _userApi.getUser();
    return _user = res;
  }

  /// Fetch all users
  Future<List<User>> getUsers() => _userApi.getUsers();

  /// Retrieves the currently authenticated user image
  Future<Uint8List> getCurrentUserAvatar() async {
    final res = await _userApi.getAvatar(_user!.id);
    return base64Decode(res);
  }

  /// Retrieves the currently authenticated user image
  Future<void> setCurrentUserAvatar(Uint8List binary, String mimeType) async {
    await _userApi.setAvatar(binary, mimeType);
  }

  /// Removed the currently authenticated user image
  Future<void> removeCurrentUserAvatar() => _userApi.removeAvatar();

  /// Removes the current user
  void removeUser() {
    _user = null;
  }
}
