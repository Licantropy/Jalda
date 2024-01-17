import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jalda/src/core/utils/extensions/num_extensions.dart';
import 'package:jalda/src/core/utils/validator.dart';
import 'package:jalda/src/feature/app/widget/app_button.dart';
import 'package:jalda/src/feature/app/widget/app_text_form_field.dart';
import 'package:jalda/src/feature/auth/bloc/auth_bloc.dart';
import 'package:jalda/src/feature/auth/data/params/login_params.dart';
import 'package:jalda/src/feature/auth/widget/auth_scope.dart';

/// A StatefulWidget that provides a user interface for login.
///
/// This screen allows users to enter their email and password to log in. It includes
/// a form with text fields for email and password input, and buttons for login and
/// navigation to the registration screen. The email and password inputs are validated
/// using `EmailValidator` and `PasswordValidator` respectively.
class LoginScreen extends StatefulWidget {
  /// Creates a LoginScreen widget.
  ///
  /// The [key] argument is passed to the superclass for widget identification. This
  /// key can be used to identify this widget in the widget tree.
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// A global key that uniquely identifies the Form widget and allows validation of the form.
  ///
  /// This key is used to interact with the form, for example, for validation and to
  /// save form fields.
  final _formKey = GlobalKey<FormState>();

  /// Controller for the email input field.
  ///
  /// This controller manages the text being input into the email field, allowing
  /// retrieval and listening for changes.
  final _emailController = TextEditingController();

  /// Controller for the password input field.
  ///
  /// This controller manages the text being input into the password field, allowing
  /// retrieval and listening for changes.
  final _passwordController = TextEditingController();

  /// Navigates to the registration screen.
  ///
  /// This function uses the GoRouter package to navigate to the '/registration' route.
  void _toRegister() => context.go('/registration');

  /// Handles the login action.
  ///
  /// This function validates the form fields. If valid, it retrieves the email and
  /// password from their respective controllers, creates a [LoginParams] object, and
  /// calls the login method on the [AuthScope] of the current context. If the current
  /// state is [LoginLoading], this function does nothing.
  void _login() {
    if (_formKey.currentState!.validate()) {
      if (AuthScope.stateOf(context) is LoginLoading) return;
      final email = _emailController.text;
      final password = _passwordController.text;
      final params = LoginParams(email: email, password: password);

      AuthScope.of(context).login(params);

    }
  }

  /// Builds the child widget for the login button.
  ///
  /// Returns a [CupertinoActivityIndicator] if the current state is [LoginLoading],
  /// otherwise it returns a [Text] widget with 'Войти'.
  Widget _buildLoginButtonChild() =>
      AuthScope.stateOf(context) is LoginLoading ? const CupertinoActivityIndicator(color: Colors.white) : const Text('Войти');


  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 120, 16, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(alignment: Alignment.center, color: Colors.orange, height: 150, width: 150, child: const Text('Icon')),
                  20.h,
                  AppTextFormField(controller: _emailController, validator: EmailValidator(), hintText: 'Электронная почта'),
                  12.h,
                  AppTextFormField(controller: _passwordController, validator: PasswordValidator(), hintText: 'Пароль'),
                  Align(alignment: Alignment.topRight, child: TextButton(onPressed: () {}, child: const Text('Забыли пароль?'))),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(width: double.maxFinite, onPressed: _login, child: _buildLoginButtonChild()),
              10.h,
              TextButton(onPressed: _toRegister, child: const Text('Регистрация')),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    // Disposes the text controllers when the widget is removed from the widget tree.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
