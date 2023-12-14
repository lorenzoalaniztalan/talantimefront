import 'package:absence_api/absence_api.dart';

/// {@template absence_repository}
/// Dart package which manages the absence domain
/// {@endtemplate}
class AbsenceRepository {
  /// {@macro absence_repository}
  const AbsenceRepository({
    required AbsenceApi absenceApi,
  }) : _absenceApi = absenceApi;
  final AbsenceApi _absenceApi;

  /// Retrieves all absence types
  Future<List<AbsenceType>> getAllAbsenceTypes() =>
      _absenceApi.getAllAbsenceTypes();
}
