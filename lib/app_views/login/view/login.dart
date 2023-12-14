import 'dart:math';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/login/bloc/login_bloc.dart';
import 'package:turnotron/app_views/reset_password_request/view/reset_password_request.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/utils/notifications.dart';
import 'package:turnotron/widgets/footer.dart';
import 'package:turnotron/widgets/input_controller_wrapper.dart';
import 'package:turnotron/widgets/logo.dart';
import 'package:turnotron/widgets/switch.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage._());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        context.read<AuthenticationRepository>(),
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
        ? const _LoginViewMobile()
        : const _LoginViewDesktop();
  }
}

class _LoginViewDesktop extends StatelessWidget {
  const _LoginViewDesktop();

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
                        Image.asset('assets/img/login_side_panel.png'),
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
                Expanded(
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
                      spacerExpanded,
                      Padding(
                        padding: EdgeInsets.all(TalanAppDimensions.innerGap),
                        child: const _LoginForm(),
                      ),
                      spacerExpanded,
                      const TalanCopyrightFooter(
                        variant: TalanFooterVariant.justText,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginViewMobile extends StatelessWidget {
  const _LoginViewMobile();

  @override
  Widget build(BuildContext context) {
    return TalanTapToHideKeyboard(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/img/login_background_mobile.png',
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
                    470,
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
                      // style: TextStyle(color: TalanAppColors.light),
                    ),
                    spacerS,
                    Padding(
                      padding: EdgeInsets.all(TalanAppDimensions.innerGap),
                      child: const _LoginForm(),
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

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 300,
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isFailure) {
            handleError(l10n.serverErrorAuthenticationError);
          }
          if (state.status.isSuccess) {
            handleSuccess(l10n.serverResponseAuthenticationSuccess);
          }
        },
        child: AutofillGroup(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _EmailInput(),
              _PasswordInput(),
              _LoginButton(),
              spacerXL,
              const _ResetPasswordRequestButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.email.displayError != null,
          child: TextField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            onEditingComplete: TextInput.finishAutofillContext,
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (email) =>
                context.read<LoginBloc>().add(LoginEmailChanged(email)),
            onSubmitted: (_) {
              if (state.isValid) {
                context.read<LoginBloc>().add(const LoginSubmitted());
              }
            },
            decoration: InputDecoration(
              labelText: l10n.inputControllerEmailLabel,
              errorText: state.email.displayError != null
                  ? l10n.inputControllerEmailError
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.password.displayError != null,
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.send,
            key: const Key('loginForm_passwordInput_textField'),
            autofillHints: const [AutofillHints.password],
            onEditingComplete: TextInput.finishAutofillContext,
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            onSubmitted: (_) {
              if (state.isValid) {
                context.read<LoginBloc>().add(const LoginSubmitted());
              }
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: l10n.inputControllerPasswordLabel,
              errorText: state.password.displayError != null
                  ? l10n.inputControllerPasswordError
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const SizedBox(
                height: 31,
                width: 31,
                child: CircularProgressIndicator.adaptive(),
              )
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.isValid
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                child: Text(l10n.loginPageSubmitButton),
              );
      },
    );
  }
}

class _ResetPasswordRequestButton extends StatelessWidget {
  const _ResetPasswordRequestButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TextButton(
      onPressed: () => Navigator.of(context)
          .pushReplacement(ResetPasswordRequestPage.route()),
      child: Text(l10n.resetPasswordButton),
    );
  }
}
