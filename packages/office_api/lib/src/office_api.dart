import 'package:office_api/office_api.dart';

/// {@template office_api}
/// Interface and models for an API providing office related resources.
/// {@endtemplate}
abstract class OfficeApi {
  /// {@macro office_api}
  const OfficeApi();

  /// Retrieves all offices
  Future<List<Office>> getAllOffices();
}
