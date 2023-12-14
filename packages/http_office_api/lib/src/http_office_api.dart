import 'package:common_models_repository/common_models_repository.dart';
import 'package:dio/dio.dart';
import 'package:office_api/office_api.dart';

/// {@template http_office_api}
/// A Flutter implementation of the office_api with dio.
/// {@endtemplate}
class HttpOfficeApi extends OfficeApi {
  /// {@macro http_office_api}
  HttpOfficeApi(Dio apiClient) {
    _apiClient = apiClient;
    _route = 'offices';
  }
  late Dio _apiClient;
  late String _route;

  @override
  Future<List<Office>> getAllOffices() async {
    final res = await _apiClient.get<List<dynamic>>('/$_route/all_offices');
    return (res.data!).map((e) {
      return Office.fromJson(e as JsonMap);
    }).toList();
  }
}
