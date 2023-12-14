import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/current_user_avatar/view/current_user_avatar.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/widgets/footer.dart';
import 'package:turnotron/widgets/logo.dart';
import 'package:turnotron/widgets/switch.dart';

class TalanLayout extends StatelessWidget {
  const TalanLayout({
    super.key,
    this.child,
    this.bottom,
    this.drawerMenu,
    this.onHeaderLogoCallback,
  });
  final Widget? child;
  final PreferredSize? bottom;
  final Widget? drawerMenu;
  final VoidCallback? onHeaderLogoCallback;

  @override
  Widget build(BuildContext context) {
    final isDesktop =
        ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP);
    return Scaffold(
      endDrawer: isDesktop
          ? null
          : _TalanDrawer(
              menuContent: drawerMenu,
            ),
      appBar: _TalanHeader(
        bottom: bottom,
        displayActions: isDesktop,
        onHeaderLogoCallback: onHeaderLogoCallback,
      ),
      body: child,
      bottomNavigationBar: const TalanCopyrightFooter(),
    );
  }
}

class _TalanHeader extends StatefulWidget implements PreferredSizeWidget {
  const _TalanHeader({
    this.bottom,
    this.displayActions = true,
    this.onHeaderLogoCallback,
  });
  final PreferredSize? bottom;
  final bool displayActions;
  final VoidCallback? onHeaderLogoCallback;

  @override
  State<_TalanHeader> createState() => __TalanHeaderState();

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}

class __TalanHeaderState extends State<_TalanHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Theme(
        data: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: TalanTouchable(
          onPress: widget.onHeaderLogoCallback,
          child: const Logo(
            variant: LogoVariant.talantimeWhite,
          ),
        ),
      ),
      centerTitle: false,
      actions: widget.displayActions
          ? const [
              Center(child: SwitchLang()),
              spacerXs,
              Center(child: TalanSwitchTheme()),
              spacerXs,
              CurrentUserAvatarDesktopView(),
              spacerS
            ]
          : null,
      bottom: widget.bottom,
    );
  }
}

class _TalanDrawer extends StatelessWidget {
  const _TalanDrawer({this.menuContent});
  final Widget? menuContent;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = Theme.of(context).colorScheme.onBackground;
    final l10n = AppLocalizations.of(context);
    return Drawer(
      width: 300,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CurrentUserAvatarMobileView(),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
                child: (menuContent != null)
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: TalanAppDimensions.cardSmallSpacing,
                          vertical: spacerS.height ??
                              TalanAppDimensions.cardSmallSpacing,
                        ),
                        child: menuContent,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                spacerS,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: TalanAppDimensions.cardSmallSpacing * 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(l10n.drawerMenuLanguageSwitchLabel),
                      ),
                      SwitchLang(
                        color: foregroundColor,
                      )
                    ],
                  ),
                ),
                spacerS,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: TalanAppDimensions.cardSmallSpacing * 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(l10n.drawerMenuThemeSwitchLabel)),
                      TalanSwitchTheme(
                        color: foregroundColor,
                      )
                    ],
                  ),
                ),
                spacerS,
              ],
            )
          ],
        ),
      ),
    );
  }
}
