import 'package:office_api/office_api.dart';

/// {@template office_repository}
/// Dart package which manages the office domain
/// {@endtemplate}
class OfficeRepository {
  /// {@macro office_repository}
  const OfficeRepository({
    required OfficeApi officeApi,
  }) : _officeApi = officeApi;
  final OfficeApi _officeApi;

  /// Retrieves all offices
  Future<List<Office>> getAllOffices() => _officeApi.getAllOffices();
}
