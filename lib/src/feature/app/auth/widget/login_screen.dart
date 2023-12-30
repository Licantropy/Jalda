import 'package:flutter/material.dart';
import 'package:jalda/src/core/utils/extensions/num_extensions.dart';
import 'package:jalda/src/feature/app/widget/app_button.dart';
import 'package:jalda/src/feature/app/widget/app_text_field.dart';

///
class LoginScreen extends StatelessWidget {
  /// Login screen to authorize the user
  LoginScreen({super.key});

  /// Email controller to hold the value of TextField
  final loginController = TextEditingController();

  /// Controller to hold the value of TextField
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 120, 16, 0),
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
        bottomSheet: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppButton(text: 'Войти'),
              10.h,
              TextButton(onPressed: () {}, child: const Text('Регистрация')),
            ],
          ),
        ),
      );
}
