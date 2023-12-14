import 'package:common_models_repository/common_models_repository.dart';
import 'package:dio/dio.dart';
import 'package:http_schedule_api/http_schedule_api.dart';
import 'package:intl/intl.dart';
import 'package:schedule_api/schedule_api.dart';

/// {@template http_schedule_api}
/// A Flutter implementation of the schedule_api
/// {@endtemplate}
class HttpScheduleApi extends ScheduleApi {
  /// {@macro http_schedule_api}
  HttpScheduleApi(Dio apiClient) {
    _apiClient = apiClient;
    _route = 'schedule';
  }

  late Dio _apiClient;
  late String _route;

  @override
  Future<MonthSchedule> getMonthSchedule({
    required int userId,
    required int month,
    required int year,
  }) async {
    final params = [month, year].map((e) => e.toString()).join('/');
    final res = await _apiClient.get<JsonMap>('/$_route/$params');

    return MonthSchedule.fromJson(res.data!);
  }

  @override
  Future<MonthHistorySchedule> getConfirmedMonthSchedule({
    required int userId,
    required int month,
    required int year,
  }) async {
    final params = [userId, month, year].map((e) => e.toString()).join('/');
    final res =
        await _apiClient.get<JsonMap>('/$_route/get_month_schedule/$params');

    return MonthHistorySchedule.fromJson(res.data!);
  }

  @override
  Future<void> sendMonthScheduleConfirmation({
    required int userId,
    required Map<int, WorkingDay> schedule,
    required Map<int, AbsenceDay> absence,
  }) async {
    final params = userId.toString();
    final data = <String, dynamic>{};
    final scheduleData = <String, dynamic>{};
    final absenceData = <String, dynamic>{};

    for (final key in schedule.keys) {
      scheduleData[key.toString()] = schedule[key]!.toJson();
    }
    for (final key in absence.keys) {
      absenceData[key.toString()] = absence[key]!.toJson();
    }
    data['schedule'] = scheduleData;
    data['absence'] = absenceData;
    await _apiClient.post<dynamic>(
      '/$_route/new_schedule/$params',
      data: data,
    );
  }

  @override
  Future<ScheduleHoursTime> getUsualSchedule() async {
    final res = await _apiClient.get<List<dynamic>>('/favorite');
    return ScheduleHoursTime.fromJson(res.data![0] as JsonMap);
  }

  @override
  Future<void> setUsualSchedule<TimeOfDaySerializable>({
    required int userId,
    required ScheduleHours<TimeOfDaySerializable> schedule,
  }) async {
    final data = schedule.toJson();
    await _apiClient.post<dynamic>(
      '/favorite',
      data: data,
    );
  }

  @override
  Future<List<MonthTimeSerializable>> getUnconfirmedMonths(int userId) async {
    final res = await _apiClient
        .get<List<dynamic>>('/$_route/get_previous_unconfirmed_months');
    return res.data!
        .map((e) => MonthTimeSerializable.fromJson(e as JsonMap))
        .toList();
  }

  @override
  Future<void> deleteMonthScheduleConfirmation({
    required int userId,
    required int month,
    required int year,
  }) {
    final queryParams = {
      'user_id': userId,
      'month': month,
      'year': year,
    };
    return _apiClient.delete<dynamic>(
      '/$_route/delete_confirmed_schedules',
      queryParameters: queryParams,
    );
  }

  @override
  Future<dynamic> downloadReport({
    required DateTime from,
    required DateTime to,
    required List<int> users,
    required bool includeNonWorkingDays,
    required bool includeAbsenceDays,
  }) async {
    final queryParams = {
      'start_date': DateFormat('yyyy-MM-dd').format(from),
      'end_date': DateFormat('yyyy-MM-dd').format(to),
      'users_ids': users.map((e) => e.toString()).join(','),
      'include_non_working_days': includeNonWorkingDays.toString(),
      'include_absence_days': includeAbsenceDays.toString(),
    };
    final params = Uri(
      path: '/reports/get-confirmed-schedules-report',
      queryParameters: queryParams,
    );
    final res = await _apiClient.getUri<dynamic>(
      params,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    return res.data as List<int>;
  }

  @override
  Future<void> sendDayScheduleConfirmation({
    required int userId,
    required ScheduleDay day,
  }) async {
    await _apiClient.post<dynamic>(
      '/$_route/day/confirm',
      data: day.toJson(),
    );
  }
}
