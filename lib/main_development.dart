import 'package:absence_repository/absence_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:http_absence_api/http_absence_api.dart';
import 'package:http_authentication_api/http_authentication_api.dart';
import 'package:http_office_api/http_office_api.dart';
import 'package:http_schedule_api/http_schedule_api.dart';
import 'package:http_user_api/http_user_api.dart';
import 'package:office_repository/office_repository.dart';
import 'package:preferences_repository/preferences_repository.dart';
import 'package:schedule_repository/schedule_repository.dart';
import 'package:secure_preferences_api/secure_preferences_api.dart';
import 'package:turnotron/app/app.dart';
import 'package:turnotron/bootstrap.dart';
import 'package:turnotron/utils/http_client_setup.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  await bootstrap(
    () async {
      final apiClient = HttpClientSetup('http://127.0.0.1:5000/api');
      await apiClient.initializeClient();
      const preferencesRepository = PreferencesRepository(
        preferencesApi: SecurePreferencesApi(client: FlutterSecureStorage()),
      );
      final authenticationRepository = AuthenticationRepository(
        authenticationApi: HttpAuthenticationApi(apiClient.apiClient),
        onReceivedTokenCallback: apiClient.storeToken,
      );
      final userRepository =
          UserRepository(userApi: HttpUserApi(apiClient.apiClient));
      final scheduleRepository =
          ScheduleRepository(scheduleApi: HttpScheduleApi(apiClient.apiClient));
      final officeRepository =
          OfficeRepository(officeApi: HttpOfficeApi(apiClient.apiClient));
      final absenceRepository =
          AbsenceRepository(absenceApi: HttpAbsenceApi(apiClient.apiClient));
      return App(
        preferencesRepository: preferencesRepository,
        authenticationRepository: authenticationRepository,
        userRepository: userRepository,
        scheduleRepository: scheduleRepository,
        officeRepository: officeRepository,
        absenceRepository: absenceRepository,
      );
    },
  );
}
