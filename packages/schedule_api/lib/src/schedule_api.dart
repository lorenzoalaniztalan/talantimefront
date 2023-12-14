import 'package:schedule_api/schedule_api.dart';

/// {@template schedule_api}
/// Interface for an API providing management access to schedules
/// {@endtemplate}
abstract class ScheduleApi {
  /// {@macro schedule_api}
  const ScheduleApi();

  /// Retrieves all days of a given month and year. Each day can be working day,
  /// a non working day (bank holiday) or holiday (an absence requested by
  /// the user).
  Future<MonthSchedule> getMonthSchedule({
    required int userId,
    required int month,
    required int year,
  });

  /// Retrieves all confirmed working days of a given month and year.
  Future<MonthHistorySchedule> getConfirmedMonthSchedule({
    required int userId,
    required int month,
    required int year,
  });

  /// Confirms the month and year with the data ([schedule] and [absence]).
  Future<void> sendMonthScheduleConfirmation({
    required int userId,
    required Map<int, WorkingDay> schedule,
    required Map<int, AbsenceDay> absence,
  });

  /// Confirms the day with the data.
  Future<void> sendDayScheduleConfirmation({
    required int userId,
    required ScheduleDay day,
  });

  /// Retrieves the usual schedule of a given user.
  Future<ScheduleHours> getUsualSchedule();

  /// Sets the usual schedule of a given user.
  Future<void> setUsualSchedule<T>({
    required int userId,
    required ScheduleHours<T> schedule,
  });

  /// Retrieves all unconfirmed months of a given user.
  Future<List<MonthTimeSerializable>> getUnconfirmedMonths(int userId);

  /// Deletes all confirmed days the month and year with the data.
  Future<void> deleteMonthScheduleConfirmation({
    required int userId,
    required int month,
    required int year,
  });

  /// Download report file for a given month, year and users.
  Future<dynamic> downloadReport({
    required DateTime from,
    required DateTime to,
    required List<int> users,
    required bool includeNonWorkingDays,
    required bool includeAbsenceDays,
  });
}
