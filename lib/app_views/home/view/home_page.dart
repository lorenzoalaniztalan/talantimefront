import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:turnotron/app_views/admin/view/admin_page.dart';
import 'package:turnotron/app_views/authentication/bloc/authentication_bloc.dart';
import 'package:turnotron/app_views/confirm_hours/view/confirm_hours.dart';
import 'package:turnotron/app_views/home/widgets/tab_button.dart';
import 'package:turnotron/app_views/master_data/view/master_data.dart';
import 'package:turnotron/app_views/preferences/bloc/preferences_bloc.dart';
import 'package:turnotron/app_views/register/view/register.dart';
import 'package:turnotron/app_views/regular_schedule_setup/view/regular_schedule_setup_page.dart';
import 'package:turnotron/app_views/schedule_report/view/schedule_report.dart';
import 'package:turnotron/app_views/settings/view/settings_page.dart';
import 'package:turnotron/app_views/welcome/view/welcome_page.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/widgets/layout.dart';

class HomePage extends StatelessWidget {
  const HomePage._();

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const MasterDataProvider(child: HomePage._()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const _HomeViewTabController();
  }
}

class _HomeViewTabController extends StatefulWidget {
  const _HomeViewTabController();

  @override
  State<_HomeViewTabController> createState() => _HomeViewTabControllerState();
}

class _HomeViewTabControllerState extends State<_HomeViewTabController>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentIndex;
  late bool _isFirstLogin;
  late bool _isAdmin;

  @override
  void initState() {
    super.initState();
    _isFirstLogin = context.read<PreferencesBloc>().state.isFirstLogin;
    _isAdmin = context.read<AuthenticationBloc>().state.user.isAdmin;

    var initialIndex = 1;
    // if (_isAdmin) {
    //   initialIndex = 3;
    // }
    if (_isFirstLogin) {
      initialIndex = 0;
    }
    _tabController = TabController(
      initialIndex: initialIndex,
      vsync: this,
      animationDuration: Duration.zero,
      length: 4 + (_isAdmin ? 1 : 0),
    );
    _currentIndex = initialIndex;
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    if (_isFirstLogin) {
      context.read<PreferencesBloc>().add(const PreferencesSetFirstLogin());
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tabs = [
      l10n.homePageHomeSectionTitle,
      l10n.homePageSubmitScheduleSectionTitle,
      // l10n.homePageHistorySectionTitle,
      l10n.settingsPageTitle
    ];
    if (context.read<AuthenticationBloc>().state.user.isAdmin) {
      tabs.add(l10n.adminPageTitle);
    }
    final isDesktop =
        ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP);
    return TalanLayout(
      onHeaderLogoCallback: () {
        _tabController.animateTo(0);
      },
      drawerMenu: isDesktop
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (int i = 0; i < tabs.length; i++)
                  HomeTabDrawerButton(
                    groupValue: _currentIndex,
                    value: i,
                    label: tabs[i],
                    onPressed: () => _tabController.animateTo(i),
                  )
              ],
            ),
      bottom: isDesktop
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight * .5),
              child: SizedBox(
                height: kToolbarHeight * .6,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (int i = 0; i < tabs.length; i++)
                          HomeTabButton(
                            groupValue: _currentIndex,
                            value: i,
                            label: tabs[i],
                            onPressed: () => _tabController.animateTo(i),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
      child: TabBarView(
        controller: _tabController,
        children: [
          ...[
            const WelcomePage(),
            const ConfirmHoursPage(),
            // const HistorySchedulePage(),
            SettingsPage(
              onNavigateEditUsualSchedule: () =>
                  _tabController.animateTo(_isAdmin ? 4 : 3),
            ),
          ],
          ..._isAdmin
              ? [
                  AdminPage(
                    handleRegisterNavigation: () =>
                        Navigator.of(context).push(RegisterPage.route()),
                    handleReportNavigation: () {
                      showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(l10n.generateReportModalTitle),
                          content: const ScheduleReportView(),
                        ),
                      );
                    },
                  ),
                  RegularScheduleSetupPage(
                    onBack: () => _tabController.animateTo(2),
                  ),
                ]
              : [
                  RegularScheduleSetupPage(
                    onBack: () => _tabController.animateTo(2),
                  ),
                ]
        ],
      ),
    );
  }
}
