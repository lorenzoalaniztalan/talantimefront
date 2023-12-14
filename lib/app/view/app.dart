import 'package:absence_repository/absence_repository.dart';
import 'package:authentication_api/authentication_api.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_repository/office_repository.dart';
import 'package:preferences_repository/preferences_repository.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:schedule_repository/schedule_repository.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/authentication/bloc/authentication_bloc.dart';
import 'package:turnotron/app_views/email_verification/view/email_verification.dart';
import 'package:turnotron/app_views/home/view/home_page.dart';
import 'package:turnotron/app_views/loading/view/loading_page.dart';
import 'package:turnotron/app_views/login/view/login.dart';
import 'package:turnotron/app_views/master_data/bloc/master_data_bloc.dart';
import 'package:turnotron/app_views/preferences/bloc/preferences_bloc.dart';
import 'package:turnotron/app_views/providers/locale_provider.dart';
import 'package:turnotron/app_views/reset_password/view/reset_password.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/utils/precache_images.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  /// Dependency injection of repositories.
  const App({
    required this.authenticationRepository,
    required this.userRepository,
    required this.scheduleRepository,
    required this.preferencesRepository,
    required this.officeRepository,
    required this.absenceRepository,
    super.key,
  });

  final PreferencesRepository preferencesRepository;
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final ScheduleRepository scheduleRepository;
  final OfficeRepository officeRepository;
  final AbsenceRepository absenceRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => preferencesRepository,
        ),
        RepositoryProvider(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider(
          create: (context) => userRepository,
        ),
        RepositoryProvider(
          create: (context) => scheduleRepository,
        ),
        RepositoryProvider(
          create: (context) => officeRepository,
        ),
        RepositoryProvider(
          create: (context) => absenceRepository,
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TalanThemeProvider()),
          ChangeNotifierProvider(
            create: (context) => LocaleProvider(
              WidgetsBinding.instance.platformDispatcher.locale,
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationBloc(
                authenticationRepository: authenticationRepository,
                userRepository: userRepository,
              ),
            ),
            BlocProvider(
              create: (context) => MasterDataBloc(
                officeRepository: officeRepository,
                absenceRepository: absenceRepository,
                userRepository: userRepository,
              ),
            ),
            BlocProvider(
              create: (context) => PreferencesBloc(
                preferencesRepository: preferencesRepository,
              ),
            ),
          ],
          child: const MyPresentationApp(),
        ),
      ),
    );
  }
}

class MyPresentationApp extends StatefulWidget {
  const MyPresentationApp({super.key});

  @override
  State<MyPresentationApp> createState() => _MyPresentationAppState();
}

class _MyPresentationAppState extends State<MyPresentationApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talantime',
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: TalanAppTheme.light,
      darkTheme: TalanAppTheme.dark,
      themeMode: Provider.of<TalanThemeProvider>(context).mode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Provider.of<LocaleProvider>(context).locale,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      builder: (context, child) {
        return ResponsiveBreakpoints(
          breakpoints: const [
            Breakpoint(start: 0, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 800, name: TABLET),
            Breakpoint(start: 801, end: 1920, name: DESKTOP),
            Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
          child: MultiBlocListener(
            listeners: [
              /// Auth flow implemented as recommended by the bloc library.
              ///
              /// (see https://bloclibrary.dev/#/flutterlogintutorial).
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) async {
                  await precacheAssetImages(context);
                  final path = Uri.base.toString();
                  final params = Uri.base.queryParameters;

                  if (EmailVerificationPage.matchesPath(path)) {
                    await _navigator.pushAndRemoveUntil<void>(
                      EmailVerificationPage.route(
                        params: params,
                        onSuccess: () => context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationEmailVerified()),
                      ),
                      (route) => false,
                    );
                    return;
                  }
                  if (ResetPasswordPage.matchesPath(path)) {
                    await _navigator.pushAndRemoveUntil<void>(
                      ResetPasswordPage.route(
                        params: params,
                      ),
                      (route) => false,
                    );
                    return;
                  }
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      await _navigator.pushAndRemoveUntil<void>(
                        HomePage.route(),
                        (route) => false,
                      );
                    case AuthenticationStatus.unauthenticated:
                      await _navigator.pushAndRemoveUntil<void>(
                        LoginPage.route(),
                        (route) => false,
                      );
                    case AuthenticationStatus.unknown:
                  }
                },
              ),
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == AuthenticationStatus.authenticated) {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationUserAvatarRequested());
                    context.read<MasterDataBloc>().add(
                          MasterDataFetchAll(
                            isAdmin: state.user.isAdmin,
                          ),
                        );
                    context
                        .read<PreferencesBloc>()
                        .add(const PreferencesFetchFirstLogin());
                  }
                },
              ),
            ],
            child: child!,
          ),
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
