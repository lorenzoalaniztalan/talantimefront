import 'dart:async';

import 'package:authentication_api/authentication_api.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

/// {@template http_authentication_api}
/// A Flutter implementation of the authentication_api with dio
/// {@endtemplate}
class HttpAuthenticationApi extends AuthenticationApi {
  /// {@macro http_authentication_api}
  HttpAuthenticationApi(Dio apiClient) {
    _apiClient = apiClient;
    _route = 'account';
  }

  late Dio _apiClient;
  late String _route;

  @override
  Future<Response<dynamic>> logIn({
    required String email,
    required String password,
  }) {
    final data = {'email': email, 'password': password};
    return _apiClient.post<dynamic>(
      '/$_route/authenticate',
      data: data,
    );
  }

  @override
  Future<void> logOut() {
    return _apiClient.post<dynamic>(
      '/$_route/logout',
    );
  }

  @override
  Future<dynamic> register({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String officeCode,
    required DateTime registrationDate,
    required String employeeId,
  }) async {
    final data = {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'office_code': officeCode,
      'registration_date':
          DateFormat('yyyy-MM-dd HH:mm:ss').format(registrationDate),
      'employee_id': employeeId,
    };
    return _apiClient.post<dynamic>(
      '/$_route/register',
      data: data,
    );
  }

  @override
  Future<void> verifyUserEmail({
    required String email,
    required String code,
  }) async {
    final params = {'email': email, 'code': code};
    final uri = Uri(queryParameters: params).query;
    await _apiClient.post<dynamic>('/$_route/confirm-email?$uri');
  }

  @override
  Future<void> sendResetPasswordRequest({required String email}) async {
    final body = {
      'email': email,
    };
    await _apiClient.post<dynamic>(
      '/$_route/reset_password/request',
      data: body,
    );
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String password,
    required String token,
  }) async {
    final body = {
      'email': email,
      'new_password': password,
      'token': token,
    };
    await _apiClient.post<dynamic>(
      '/$_route/reset_password',
      data: body,
    );
  }
}
