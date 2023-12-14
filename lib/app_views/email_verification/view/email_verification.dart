import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/email_verification/bloc/email_verification_bloc.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/widgets/error_widget.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage._({
    required this.onSuccess,
    this.email,
    this.code,
  });
  final String? email;
  final String? code;
  final void Function() onSuccess;

  static bool matchesPath(String path) =>
      path.contains('/account/confirm-email');

  static Route<void> route({
    required Map<String, String> params,
    required void Function() onSuccess,
  }) {
    final email = params['email'];
    final code = params['code'];
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/'),
      builder: (_) => EmailVerificationPage._(
        email: email,
        code: code,
        onSuccess: onSuccess,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (email == null || email!.isEmpty || code == null || code!.isEmpty) {
      return Scaffold(
        body: Center(child: TalanErrorWidget(message: l10n.brokenLink)),
      );
    }
    return BlocProvider(
      create: (_) => EmailVerificationBloc(
        context.read<AuthenticationRepository>(),
      )..add(EmailVerificationSubmitted(email: email!, code: code!)),
      child: _EmailVerificationView(onSuccess),
    );
  }
}

class _EmailVerificationView extends StatelessWidget {
  const _EmailVerificationView(this.onSuccess);
  final void Function() onSuccess;

  @override
  Widget build(BuildContext context) {
    return TalanTapToHideKeyboard(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: BlocListener<EmailVerificationBloc, EmailVerificationState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status.isSuccess) {
                  Future.delayed(
                    const Duration(seconds: 3),
                    onSuccess,
                  );
                }
              },
              child: BlocBuilder<EmailVerificationBloc, EmailVerificationState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  if (state.status.isSuccess) {
                    return const _SuccessView();
                  }
                  if (state.status.isFailure) {
                    return const _ErrorView();
                  }
                  return const _LoadingView();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TalanText.headlineLarge(text: l10n.emailVerificationPageVerifyingEmail),
        spacerM,
        const SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator.adaptive(),
        ),
        spacerM,
        const TalanText.bodyLarge(text: ''),
      ],
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TalanText.headlineLarge(
          text: l10n.emailVerificationPageVerificationSuccess,
        ),
        spacerM,
        const SizedBox(
          width: 30,
          height: 30,
          child: Center(
            child: Icon(
              Icons.check_circle,
              color: TalanAppColors.success,
              size: 30,
            ),
          ),
        ),
        spacerM,
        TalanText.bodyLarge(text: l10n.emailVerificationPageRedirecting),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TalanText.headlineLarge(text: l10n.defaultServerError),
        spacerM,
        const SizedBox(
          width: 30,
          height: 30,
          child: Center(
            child: Icon(
              Icons.error,
              color: TalanAppColors.error,
              size: 30,
            ),
          ),
        ),
        spacerM,
        TalanText.bodyLarge(text: l10n.brokenLink),
      ],
    );
  }
}
