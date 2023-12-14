import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/authentication/bloc/authentication_bloc.dart';
import 'package:turnotron/app_views/edit_avatar/view/edit_avatar.dart';
import 'package:turnotron/domain/models/menu_option_item.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/widgets/user_avatar.dart';

class CurrentUserAvatarDesktopView extends StatelessWidget {
  const CurrentUserAvatarDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CurrentUserAvatarDesktopView();
  }
}

class CurrentUserAvatarMobileView extends StatelessWidget {
  const CurrentUserAvatarMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CurrentUserAvatarMobileView();
  }
}

class _CurrentUserAvatarDesktopView extends StatelessWidget {
  const _CurrentUserAvatarDesktopView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final avatarOptions = [
      MenuOptionItem(
        text: l10n.editAvatarTitle,
        callback: () => showDialog<void>(
          context: context,
          builder: (_) => const EditAvatarView(),
        ),
      ),
      MenuOptionItem(
        text: l10n.logout,
        callback: () => context
            .read<AuthenticationBloc>()
            .add(AuthenticationLogoutRequested()),
      ),
    ];
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        // hoverColor: Colors.transparent,
      ),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return PopupMenuButton(
            position: PopupMenuPosition.under,
            tooltip: state.user.toString(),
            onSelected: (value) => avatarOptions[value].callback(),
            itemBuilder: (BuildContext context) =>
                List.generate(avatarOptions.length, (index) {
              final option = avatarOptions[index];
              return PopupMenuItem(
                value: index,
                child: TalanText.bodySmall(
                  text: option.text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              );
            }),
            child: Center(
              child: SizedBox(
                height: 36,
                width: 36,
                child: UserAvatar(
                  user: state.user,
                  photo: state.photo,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CurrentUserAvatarMobileView extends StatelessWidget {
  const _CurrentUserAvatarMobileView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.all(TalanAppDimensions.cardSmallSpacing),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 60,
              width: 60,
              child: TalanTouchable(
                onPress: () => showDialog<void>(
                  context: context,
                  builder: (_) => const EditAvatarView(),
                ),
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return UserAvatar(
                      user: state.user,
                      photo: state.photo,
                      inverted: true,
                      fontSize: 20,
                    );
                  },
                ),
              ),
            ),
          ),
          spacerS,
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: TalanAppDimensions.cardSmallSpacing,
              ),
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  final user = state.user;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TalanText.headlineSmall(
                        text: user.toString(),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        user.email,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () => context
                              .read<AuthenticationBloc>()
                              .add(AuthenticationLogoutRequested()),
                          icon: const Icon(Icons.logout),
                          label: Text(l10n.logout),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
