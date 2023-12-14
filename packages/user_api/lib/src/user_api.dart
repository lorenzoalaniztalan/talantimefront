import 'dart:typed_data';

import 'package:user_api/user_api.dart';

/// {@template user_api}
/// Interface and models for an API providingh management access to users.
/// {@endtemplate}
abstract class UserApi {
  /// {@macro user_api}
  const UserApi();

  /// Retrieves the current authenticated user
  Future<User?> getUser();

  /// Fetch all users
  Future<List<User>> getUsers();

  /// Retrieves the avatar image of a given user
  Future<String> getAvatar(int userId);

  /// Uploads an image for a given user
  Future<void> setAvatar(Uint8List binary, String mimeType);

  /// Removes the avatar image of the user
  Future<void> removeAvatar();
}
