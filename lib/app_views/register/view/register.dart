import 'package:authentication_repository/authentication_repository.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/master_data/master_data.dart';
import 'package:turnotron/app_views/refresh_view/bloc/refresh_view_bloc.dart';
import 'package:turnotron/app_views/refresh_view/view/refresh_view.dart';
import 'package:turnotron/app_views/register/bloc/register_bloc.dart';
import 'package:turnotron/app_views/register/models/email.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/utils/notifications.dart';
import 'package:turnotron/utils/static_data.dart';
import 'package:turnotron/widgets/input_controller_wrapper.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage._();

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RefreshViewWidget(child: RegisterPage._()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(
        context.read<AuthenticationRepository>(),
      ),
      child: const _RegisterViewMobile(),
    );
  }
}

class _RegisterViewMobile extends StatelessWidget {
  const _RegisterViewMobile();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TalanTapToHideKeyboard(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox.expand(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        label: Text(l10n.back),
                        icon: const Icon(Icons.chevron_left),
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        ),
                      ),
                    ),
                  ),
                  spacerS,
                  Padding(
                    padding: EdgeInsets.all(TalanAppDimensions.innerGap),
                    child: const _RegisterForm(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocListener<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure) {
          var message = l10n.serverErrorRegisterErrorGeneric;
          if (state.responseCode == 409) {
            message = l10n.serverErrorRegisterErrorConflict;
          }
          if (state.responseCode == 400) {
            message = l10n.serverErrorRegisterErrorInvalidTalanEmail;
          }
          handleError(message);
        }
        if (state.status.isSuccess) {
          handleSuccess(l10n.serverResponseRegisterSuccess);
          context.read<RefreshViewBloc>().add(const RefreshViewRefreshEvent());
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            child: AutofillGroup(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _FirstnameInput(),
                  _LastnameInput(),
                  _EmailInput(),
                  _OfficeInput(),
                  _RegistrationDateInput(),
                  _EmployeeIdInput(),
                  _PasswordInput(),
                  _RegisterButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FirstnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.firstname != current.firstname,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.firstname.displayError != null,
          child: TextField(
            keyboardType: TextInputType.name,
            autofillHints: const [AutofillHints.name],
            key: const Key('registerForm_usernameInput_textField'),
            onChanged: (firstname) => context
                .read<RegisterBloc>()
                .add(RegisterFirstnameChanged(firstname)),
            decoration: InputDecoration(
              labelText: l10n.inputControllerFirstnameLabel,
              errorText: state.firstname.displayError != null
                  ? l10n.inputControllerFirstnameError
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _LastnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.lastname != current.lastname,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.lastname.displayError != null,
          child: TextField(
            keyboardType: TextInputType.name,
            autofillHints: const [AutofillHints.familyName],
            key: const Key('registerForm_lastnamenameInput_textField'),
            onChanged: (lastname) => context
                .read<RegisterBloc>()
                .add(RegisterLastnameChanged(lastname)),
            decoration: InputDecoration(
              labelText: l10n.inputControllerLastnameLabel,
              errorText: state.lastname.displayError != null
                  ? l10n.inputControllerLastnameError
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _EmployeeIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.employeeId != current.employeeId,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.employeeId.displayError != null,
          child: TextField(
            keyboardType: TextInputType.name,
            key: const Key('registerForm_employeeIdnameInput_textField'),
            onChanged: (employeeId) => context
                .read<RegisterBloc>()
                .add(RegisterEmployeeIdChanged(employeeId)),
            decoration: InputDecoration(
              labelText: l10n.inputControllerEmployeeIdLabel,
              errorText: state.employeeId.displayError != null
                  ? l10n.inputControllerEmployeeIdError
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.email.displayError != null,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            key: const Key('registerForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
            decoration: InputDecoration(
              labelText: l10n.inputControllerEmailLabel,
              errorText:
                  _getEmailValidationError(state.email.displayError, context),
            ),
          ),
        );
      },
    );
  }
}

String? _getEmailValidationError(
  EmailValidationError? error,
  BuildContext context,
) {
  if (error == null) {
    return null;
  }
  final l10n = AppLocalizations.of(context);
  if (error == EmailValidationError.empty) {
    return l10n.inputControllerEmailError;
  }
  if (error == EmailValidationError.format) {
    return l10n.inputControllerEmailError;
  }
  if (error == EmailValidationError.talanInvalid) {
    return l10n.inputControllerEmailErrorTalanInvalid;
  }
  return null;
}

class _PasswordInput extends StatefulWidget {
  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  late TextEditingController _controller;
  late bool _hasError;

  @override
  void initState() {
    _controller = TextEditingController();
    _hasError = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return IgnorePointer(
      child: BlocListener<RegisterBloc, RegisterState>(
        listenWhen: (previous, current) =>
            previous.password != current.password,
        listener: (context, state) {
          _controller.text = state.password.value;
          final hasError = state.password.displayError != null;
          if (_hasError != hasError) {
            setState(() {
              _hasError = hasError;
            });
          }
        },
        child: Opacity(
          opacity: 0.5,
          child: InputControllerSpaceError(
            hasError: _hasError,
            child: TextField(
              controller: _controller,
              key: const Key('registerForm_passwordInput_textField'),
              readOnly: true,
              decoration: InputDecoration(
                labelText: l10n.inputControllerPasswordLabel,
                errorText:
                    _hasError ? l10n.inputControllerPasswordErrorShort : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OfficeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.officeCode != current.officeCode,
      builder: (context, state) {
        final offices = context.read<MasterDataBloc>().state.offices;
        return InputControllerSpaceError(
          hasError: state.officeCode.displayError != null,
          child: DropdownButtonFormField<String>(
            focusColor: Colors.transparent,
            key: const Key('registerForm_officeInput_dropdownField'),
            value: state.officeCode.value == '' ? null : state.officeCode.value,
            onChanged: (value) =>
                context.read<RegisterBloc>().add(RegisterOfficeChanged(value!)),
            decoration: InputDecoration(
              labelText: l10n.inputControllerOfficeLabel,
              errorText: state.officeCode.displayError != null
                  ? l10n.inputControllerOfficeError
                  : null,
            ),
            items: List.generate(offices.length, (index) {
              final office = offices[index];
              return DropdownMenuItem(
                value: office.code,
                child: Text(office.name),
              );
            }),
          ),
        );
      },
    );
  }
}

class _RegistrationDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.registrationDate != current.registrationDate,
      builder: (context, state) {
        return InputControllerSpaceError(
          hasError: state.registrationDate.displayError != null,
          child: DateTimeFormField(
            mode: DateTimeFieldPickerMode.date,
            autovalidateMode: AutovalidateMode.always,
            firstDate: firstDayForCalendars,
            lastDate: DateTime.now(),
            decoration: InputDecoration(
              isDense: false,
              labelText: l10n.inputControllerRegistrationDateLabel,
              errorText: state.registrationDate.displayError != null
                  ? l10n.inputControllerRegistrationDateError
                  : null,
            ),
            initialDate: state.registrationDate.value,
            initialValue: state.registrationDate.value,
            onDateSelected: (value) => context
                .read<RegisterBloc>()
                .add(RegisterRegistrationDateChanged(value)),
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isValid != current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
            ? const SizedBox(
                height: 31,
                width: 31,
                child: CircularProgressIndicator.adaptive(),
              )
            : ElevatedButton(
                key: const Key('registerForm_continue_raisedButton'),
                onPressed: (state.isValid && !state.status.isInProgress)
                    ? () {
                        context
                            .read<RegisterBloc>()
                            .add(const RegisterSubmitted());
                      }
                    : null,
                child: Text(l10n.registerPageSubmitButton),
              );
      },
    );
  }
}
