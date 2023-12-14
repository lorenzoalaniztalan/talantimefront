import 'dart:math';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/login/view/login.dart';
import 'package:turnotron/app_views/reset_password_request/bloc/reset_password_request_bloc.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/utils/notifications.dart';
import 'package:turnotron/widgets/footer.dart';
import 'package:turnotron/widgets/input_controller_wrapper.dart';
import 'package:turnotron/widgets/logo.dart';
import 'package:turnotron/widgets/switch.dart';

class ResetPasswordRequestPage extends StatelessWidget {
  const ResetPasswordRequestPage._();

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const ResetPasswordRequestPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordRequestBloc(
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
        ? const _ResetPasswordRequestViewMobile()
        : const _ResetPasswordRequestViewDesktop();
  }
}

class _ResetPasswordRequestViewDesktop extends StatelessWidget {
  const _ResetPasswordRequestViewDesktop();

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
                        child: const _ResetPasswordRequestForm(),
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

class _ResetPasswordRequestViewMobile extends StatelessWidget {
  const _ResetPasswordRequestViewMobile();

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
                      child: const _ResetPasswordRequestForm(),
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

class _ResetPasswordRequestForm extends StatelessWidget {
  const _ResetPasswordRequestForm();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocListener<ResetPasswordRequestBloc, ResetPasswordRequestState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure) {
          handleError(l10n.defaultServerError);
        }
      },
      child: BlocBuilder<ResetPasswordRequestBloc, ResetPasswordRequestState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status.isSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TalanText.displayMedium(
                  text: l10n.resetPasswordRequestSuccessTitle,
                  textAlign: TextAlign.center,
                ),
                spacerXL,
                TalanText.bodyLarge(
                  text: l10n.resetPasswordRequestSuccessSubtitle,
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
                  TalanText.bodyLarge(
                    text: l10n.resetPasswordRequestTitle,
                    textAlign: TextAlign.center,
                  ),
                  spacerL,
                  _EmailInput(),
                  _ResetPasswordRequestButton(),
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

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ResetPasswordRequestBloc, ResetPasswordRequestState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.email.displayError != null,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            key: const Key('registerForm_emailInput_textField'),
            onChanged: (email) => context
                .read<ResetPasswordRequestBloc>()
                .add(ResetPasswordRequestEmailChanged(email)),
            onSubmitted: (value) {
              if (state.isValid) {
                context
                    .read<ResetPasswordRequestBloc>()
                    .add(const ResetPasswordRequestSubmitted());
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

class _ResetPasswordRequestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ResetPasswordRequestBloc, ResetPasswordRequestState>(
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
                            .read<ResetPasswordRequestBloc>()
                            .add(const ResetPasswordRequestSubmitted());
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
