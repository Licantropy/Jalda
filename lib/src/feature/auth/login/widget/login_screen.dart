import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jalda/src/core/utils/extensions/num_extensions.dart';
import 'package:jalda/src/feature/app/widget/app_button.dart';
import 'package:jalda/src/feature/app/widget/app_text_field.dart';

///
class LoginScreen extends StatefulWidget {
  /// Login screen to authorize the user
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Email controller to hold the value of TextField
  final loginController = TextEditingController();

  /// Controller to hold the value of TextField
  final passwordController = TextEditingController();

  /// Function that routes to RegistrationScreen
  void _toRegister() => context.go('/registration');

  /// Function that routes to RegistrationScreen
  void _toHomeScreen() => context.go('/home');

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 120, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(alignment: Alignment.center, color: Colors.orange, height: 150, width: 150, child: const Text('Icon')),
                20.h,
                AppTextField(
                  controller: loginController,
                  hintText: 'Электронная почта',
                ),
                12.h,
                AppTextField(controller: passwordController, hintText: 'Пароль'),
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
              AppButton(onPressed: _toHomeScreen,text: 'Войти'),
              10.h,
              TextButton(onPressed: _toRegister, child: const Text('Регистрация')),
            ],
          ),
        ),
      );
}
