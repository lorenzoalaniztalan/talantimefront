import 'package:schedule_api/schedule_api.dart';

/// Repository data reponse
class MonthScheduleData {
  /// Basic constructor. contains a boolean [draft] and MonthScheduleMap [data]
  MonthScheduleData({
    required this.draft,
    required this.data,
  });

  /// Whether this is a confirmed month or a draft.
  final bool draft;

  /// All days associated with the relevant month and year.
  final MonthScheduleMap data;
}
