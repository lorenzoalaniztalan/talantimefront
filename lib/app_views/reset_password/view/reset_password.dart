import 'dart:math';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/login/view/login.dart';
import 'package:turnotron/app_views/reset_password/bloc/reset_password_bloc.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/utils/notifications.dart';
import 'package:turnotron/widgets/footer.dart';
import 'package:turnotron/widgets/input_controller_wrapper.dart';
import 'package:turnotron/widgets/logo.dart';
import 'package:turnotron/widgets/switch.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage._({required this.email, required this.code});
  final String email;
  final String code;

  static bool matchesPath(String path) =>
      path.contains('/account/reset-password');

  static Route<void> route({
    required Map<String, String> params,
  }) {
    final email = params['email'];
    final token = params['token'];
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/'),
      builder: (_) => ResetPasswordPage._(
        email: email!,
        code: token!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordBloc(
        context.read<AuthenticationRepository>(),
        email,
        code,
      ),
      child: const _ResponsiveViewBuilder(),
    );
  }
}

class _ResponsiveViewBuilder extends StatelessWidget {
  const _ResponsiveViewBuilder();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET)
        ? const _ResetPasswordViewMobile()
        : const _ResetPasswordViewDesktop();
  }
}

class _ResetPasswordViewDesktop extends StatelessWidget {
  const _ResetPasswordViewDesktop();

  @override
  Widget build(BuildContext context) {
    return TalanTapToHideKeyboard(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: max(
                MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                675,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SwitchLang(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      spacerExpanded,
                      Padding(
                        padding: EdgeInsets.all(TalanAppDimensions.innerGap),
                        child: const _ResetPasswordForm(),
                      ),
                      spacerExpanded,
                      const TalanCopyrightFooter(
                        variant: TalanFooterVariant.justText,
                      )
                    ],
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: TalanAppColors.primary,
                  ),
                  child: SizedBox(
                    width: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.all(8).copyWith(bottom: 0),
                            child: const Logo(
                              variant: LogoVariant.talantimeWhite,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: TalanText.headlineSmall(
                            text: 'by Talan',
                            style: TextStyle(color: TalanAppColors.light),
                          ),
                        ),
                        Image.asset('assets/img/register_side_panel.png'),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: Builder(
                                builder: (context) {
                                  final l10n = AppLocalizations.of(context);
                                  return TalanText.bodyMedium(
                                    text: l10n.appSlogan,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: TalanAppColors.light,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResetPasswordViewMobile extends StatelessWidget {
  const _ResetPasswordViewMobile();

  @override
  Widget build(BuildContext context) {
    return TalanTapToHideKeyboard(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/img/register_background_mobile.png',
              ),
              opacity: 0.2,
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: max(
                    MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                    835,
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SwitchLang(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    const Logo(),
                    const TalanText.headlineSmall(
                      text: 'by Talan',
                    ),
                    spacerS,
                    Padding(
                      padding: EdgeInsets.all(TalanAppDimensions.innerGap),
                      child: const _ResetPasswordForm(),
                    ),
                    spacerExpanded,
                    const TalanCopyrightFooter(
                      variant: TalanFooterVariant.justText,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResetPasswordForm extends StatelessWidget {
  const _ResetPasswordForm();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure) {
          handleError(l10n.defaultServerError);
        }
        if (state.status.isSuccess) {
          handleSuccess(l10n.serverResponseResetPasswordSuccess);
        }
      },
      child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status.isSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TalanText.displayMedium(
                  text: l10n.resetPasswordSuccessTitle,
                  textAlign: TextAlign.center,
                ),
                spacerXL,
                TalanText.bodyLarge(
                  text: l10n.resetPasswordSuccessSubtitle,
                  textAlign: TextAlign.center,
                ),
                spacerS,
                const _BackToLoginButton()
              ],
            );
          }
          return ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            child: AutofillGroup(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _PasswordInput(),
                  _RepeatedPasswordInput(),
                  _ResetPasswordButton(),
                  spacerXs,
                  const _BackToLoginButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.password.displayError != null,
          child: TextField(
            key: const Key('registerForm_passwordInput_textField'),
            autofillHints: const [
              AutofillHints.password,
              AutofillHints.newPassword
            ],
            onChanged: (password) => context
                .read<ResetPasswordBloc>()
                .add(ResetPasswordPasswordChanged(password)),
            onSubmitted: (value) {
              if (state.isValid) {
                context
                    .read<ResetPasswordBloc>()
                    .add(const ResetPasswordSubmitted());
              }
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: l10n.inputControllerPasswordLabel,
              errorText: state.password.displayError != null
                  ? l10n.inputControllerPasswordErrorShort
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _RepeatedPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) =>
          previous.repeatedPassword != current.repeatedPassword ||
          previous.password != current.password,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.repeatedPassword.displayError != null,
          child: TextField(
            key: const Key('registerForm_repeated_passwordInput_textField'),
            autofillHints: const [
              AutofillHints.password,
              AutofillHints.newPassword
            ],
            onChanged: (password) => context
                .read<ResetPasswordBloc>()
                .add(ResetPasswordRepeatedPasswordChanged(password)),
            onSubmitted: (value) {
              if (state.isValid) {
                context
                    .read<ResetPasswordBloc>()
                    .add(const ResetPasswordSubmitted());
              }
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: l10n.inputControllerRepeatedPasswordLabel,
              errorText: state.repeatedPassword.displayError != null
                  ? l10n.inputControllerRepeatedPasswordError
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const SizedBox(
                height: 31,
                width: 31,
                child: CircularProgressIndicator.adaptive(),
              )
            : ElevatedButton(
                key: const Key('registerForm_continue_raisedButton'),
                onPressed: state.isValid
                    ? () {
                        context
                            .read<ResetPasswordBloc>()
                            .add(const ResetPasswordSubmitted());
                      }
                    : null,
                child: Text(l10n.resetPasswordButton),
              );
      },
    );
  }
}

class _BackToLoginButton extends StatelessWidget {
  const _BackToLoginButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TextButton(
      onPressed: () => Navigator.of(context).pushReplacement(LoginPage.route()),
      child: Text(l10n.registerPageBackToLogin),
    );
  }
}
