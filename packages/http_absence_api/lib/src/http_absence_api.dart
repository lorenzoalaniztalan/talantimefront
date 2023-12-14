import 'package:absence_api/absence_api.dart';
import 'package:common_models_repository/common_models_repository.dart';
import 'package:dio/dio.dart';

/// {@template http_absence_api}
/// A Flutter implementation of the absence_api with dio.
/// {@endtemplate}
class HttpAbsenceApi extends AbsenceApi {
  /// {@macro http_absence_api}
  HttpAbsenceApi(Dio apiClient) {
    _apiClient = apiClient;
    _route = 'absence-type';
  }
  late Dio _apiClient;
  late String _route;

  @override
  Future<List<AbsenceType>> getAllAbsenceTypes() async {
    final res = await _apiClient.get<List<dynamic>>('/$_route');
    return (res.data!).map((e) {
      return AbsenceType.fromJson(e as JsonMap);
    }).toList();
  }
}
