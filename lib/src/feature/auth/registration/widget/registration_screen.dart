import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jalda/src/core/utils/extensions/num_extensions.dart';
import 'package:jalda/src/core/utils/input_masks.dart';
import 'package:jalda/src/core/utils/validator.dart';
import 'package:jalda/src/feature/app/widget/app_button.dart';
import 'package:jalda/src/feature/app/widget/app_text_form_field.dart';
import 'package:jalda/src/feature/auth/bloc/auth_bloc.dart';
import 'package:jalda/src/feature/auth/data/params/registration_params.dart';
import 'package:jalda/src/feature/auth/widget/auth_scope.dart';

/// A StatefulWidget that provides a user interface for user registration.
///
/// This screen allows users to enter their email, phone number, name, and password to register.
/// It includes text fields for entering these details and buttons for registration and
/// navigation to the login screen.
class RegistrationScreen extends StatefulWidget {
  /// Creates a RegistrationScreen widget.
  ///
  /// The [key] argument is passed to the superclass for widget identification.
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  /// Controller for the email input field.
  ///
  /// This controller manages the text being input into the email field, allowing
  /// retrieval and listening for changes.
  final _emailController = TextEditingController();

  /// Controller for the phone number input field.
  ///
  /// This controller manages the text being input into the phone number field, allowing
  /// retrieval and listening for changes.
  final _phoneController = TextEditingController();

  /// Controller for the name input field.
  ///
  /// This controller manages the text being input into the name field, allowing
  /// retrieval and listening for changes.
  final _nameController = TextEditingController();

  /// Controller for the password input field.
  ///
  /// This controller manages the text being input into the password field, allowing
  /// retrieval and listening for changes.
  final _passwordController = TextEditingController();

  /// Controller for the confirm password input field.
  ///
  /// This controller manages the text being input into the confirm password field,
  /// allowing retrieval and listening for changes.
  final _confirmPasswordController = TextEditingController();

  /// Navigates back to the login screen.
  ///
  /// This function uses the GoRouter package to navigate back to the login screen.
  void _toLogin() => context.pop();

  late final PasswordMatchValidator _passwordMatchValidator;

  bool _validatePasswordsMatch() {
    final passwordMatchError = _passwordMatchValidator.validate();
    if (passwordMatchError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(passwordMatchError)),
      );
      return false;
    }
    return true;
  }

  /// Handles the registration action.
  ///
  /// This function retrieves the user input from the controllers, creates a
  /// [RegistrationParams] object, and calls the register method on the [AuthScope] of
  /// the current context. If the current state is [RegisterLoading], this function does nothing.
  void _register() {
    if (AuthScope.stateOf(context) is RegisterLoading || !_validatePasswordsMatch()) return;

    final email = _emailController.text;
    final password = _passwordController.text;
    final phone = _phoneController.text;
    final name = _nameController.text;
    final params = RegistrationParams(
      email: email,
      password: password,
      name: name,
      phone: phone,
      role: 'tenant',
      lastName: 'lastName',
    );

    AuthScope.of(context).register(params);
  }

  /// Builds the child widget for the register button.
  ///
  /// Returns a [CupertinoActivityIndicator] if the current state is [RegisterLoading],
  /// otherwise it returns a [Text] widget with 'Зарегистрироваться'.
  Widget _buildRegisterButtonChild() => AuthScope.stateOf(context) is RegisterLoading
      ? const CupertinoActivityIndicator(color: Colors.white)
      : const Text('Зарегистрироваться',style: TextStyle(color: Colors.white));

  @override
  void initState() {
    super.initState();
    _passwordMatchValidator = PasswordMatchValidator(
      passwordController: _passwordController,
      confirmPasswordController: _confirmPasswordController,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 120, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/logo.webp', width: MediaQuery.of(context).size.width * 0.2),
                20.h,
                AppTextFormField(controller: _emailController, hintText: 'Электронная почта', validator: EmailValidator()),
                12.h,
                AppTextFormField(
                  controller: _phoneController,
                  inputFormatters: [CustomMaskTextInputFormatter.phoneFormatter()],
                  keyboardType: TextInputType.phone,
                  hintText: 'Номер телефона',
                  validator: PhoneNumberValidator(),
                ),
                12.h,
                AppTextFormField(controller: _nameController, hintText: 'Имя', validator: NameValidator()),
                12.h,
                AppTextFormField(controller: _passwordController, hintText: 'Пароль', validator: PasswordValidator()),
                12.h,
                AppTextFormField(controller: _confirmPasswordController, hintText: 'Повторите пароль', validator: PasswordValidator()),
                Align(alignment: Alignment.topRight, child: TextButton(onPressed: () {}, child: const Text('Забыли пароль?'))),
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(onPressed: _register, width: double.maxFinite, child: _buildRegisterButtonChild()),
              10.h,
              TextButton(onPressed: _toLogin, child: const Text('Войти')),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    // Disposes the text controllers when the widget is removed from the widget tree.
    _emailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
