import 'package:http_schedule_api/http_schedule_api.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:schedule_repository/schedule_repository.dart';

/// {@template schedule_repository}
/// A repository that handles schedule related requests
/// {@endtemplate}
class ScheduleRepository {
  /// {@macro schedule_repository}
  const ScheduleRepository({
    required ScheduleApi scheduleApi,
  }) : _scheduleApi = scheduleApi;

  final ScheduleApi _scheduleApi;

  /// Retrieves all days of a given month and year. Each day can be working day,
  /// a non working day (bank holiday) or holiday (an absence requested by
  /// the user).
  Future<MonthScheduleData> getMonthSchedule({
    required int userId,
    required int month,
    required int year,
  }) async {
    final res = await _scheduleApi.getMonthSchedule(
      userId: userId,
      month: month,
      year: year,
    );
    final MonthScheduleMap scheduleMonth = {};
    for (final element in res.schedule.keys) {
      final key = int.parse(element);
      scheduleMonth[key] = res.schedule[element]!;
    }
    for (final element in res.absences.keys) {
      final key = int.parse(element);
      scheduleMonth[key] = res.absences[element]!;
    }
    for (final element in res.nonWorkingDays) {
      final key = element;
      scheduleMonth[key] = NonWorkingDay(day: key, month: month, year: year);
    }
    return MonthScheduleData(draft: res.draft, data: scheduleMonth);
  }

  /// Retrieves all confirmed  days of a given month and year.
  Future<MonthScheduleMap> getConfirmedMonthSchedule({
    required int userId,
    required int month,
    required int year,
  }) async {
    final res = await _scheduleApi.getConfirmedMonthSchedule(
      userId: userId,
      month: month,
      year: year,
    );
    final MonthScheduleMap scheduleMonth = {};
    for (final element in res.schedule.keys) {
      final key = int.parse(element);
      scheduleMonth[key] = res.schedule[element]!;
    }
    for (final element in res.absences.keys) {
      final key = int.parse(element);
      scheduleMonth[key] = res.absences[element]!;
    }
    for (final element in res.nonWorkingDays) {
      final key = element;
      scheduleMonth[key] = NonWorkingDay(day: key, month: month, year: year);
    }
    return scheduleMonth;
  }

  /// Saves the current data and confirms day
  Future<void> sendDayConfirmation({
    required int userId,
    required ScheduleDay day,
  }) async {
    await _scheduleApi.sendDayScheduleConfirmation(
      userId: userId,
      day: day,
    );
  }

  /// Saves the current data and confirms the month schedule
  Future<void> sendMonthScheduleConfirmation({
    required int userId,
    required Map<int, ScheduleDay> monthSchedule,
  }) async {
    final schedule = <int, WorkingDay>{};
    final absence = <int, AbsenceDay>{};
    for (final key in monthSchedule.keys) {
      if (monthSchedule[key].runtimeType == WorkingDay) {
        schedule[key] = monthSchedule[key]! as WorkingDay;
      }
      if (monthSchedule[key].runtimeType == AbsenceDay) {
        absence[key] = monthSchedule[key]! as AbsenceDay;
      }
    }
    await _scheduleApi.sendMonthScheduleConfirmation(
      userId: userId,
      schedule: schedule,
      absence: absence,
    );
  }

  /// Retrieves the usual hours of a given user
  Future<ScheduleHoursTime> getUsualSchedule() =>
      _scheduleApi.getUsualSchedule() as Future<ScheduleHoursTime>;

  /// Sets the usual hours of a given user
  Future<void> setUsualSchedule(ScheduleHoursTime schedule) =>
      _scheduleApi.setUsualSchedule(userId: 6, schedule: schedule);

  /// Retrieves all unconfirmed months of a given user.
  Future<List<MonthTimeSerializable>> getUnconfirmedMonths(int userId) =>
      _scheduleApi.getUnconfirmedMonths(userId);

  /// Deletes all confirmed days the month and year with the data.
  Future<void> deleteMonthScheduleConfirmation({
    required int userId,
    required int month,
    required int year,
  }) =>
      _scheduleApi.deleteMonthScheduleConfirmation(
        userId: userId,
        month: month,
        year: year,
      );

  /// Download report file for a given month, year and users.
  Future<dynamic> downloadReport({
    required DateTime from,
    required DateTime to,
    required List<int> users,
    required bool includeNonWorkingDays,
    required bool includeAbsenceDays,
  }) =>
      _scheduleApi.downloadReport(
        from: from,
        to: to,
        users: users,
        includeNonWorkingDays: includeNonWorkingDays,
        includeAbsenceDays: includeAbsenceDays,
      );
}
