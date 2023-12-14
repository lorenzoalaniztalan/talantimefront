import 'package:absence_api/absence_api.dart';

/// {@template absence_api}
/// Interface and models for an API providing absence related resources.
/// {@endtemplate}
abstract class AbsenceApi {
  /// {@macro absence_api}
  const AbsenceApi();

  /// Retrieves all absence types
  Future<List<AbsenceType>> getAllAbsenceTypes();
}
