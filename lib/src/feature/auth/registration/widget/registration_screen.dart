import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jalda/src/core/utils/extensions/num_extensions.dart';
import 'package:jalda/src/feature/app/widget/app_button.dart';
import 'package:jalda/src/feature/app/widget/app_text_field.dart';

///
class RegistrationScreen extends StatefulWidget {
  /// Registration screen to authorize the user
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  /// Email controller to hold the value of TextField
  final emailController = TextEditingController();

  /// Controller to hold the value of TextField
  final phoneController = TextEditingController();

  /// Controller to hold the value of TextField
  final nameController = TextEditingController();

  /// Controller to hold the value of TextField
  final passwordController = TextEditingController();

  /// Controller to hold the value of TextField
  final confirmPasswordController = TextEditingController();


  /// Function that pops to LoginScreen
  void _toLogin() => context.pop();

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 120, 16, 0),
          child: Column(
            children: [
              Container(alignment: Alignment.center, color: Colors.orange, height: 150, width: 150, child: const Text('Icon')),
              20.h,
              AppTextField(controller: emailController, hintText: 'Электронная почта'),
              12.h,
              AppTextField(controller: phoneController, hintText: 'Номер телефона'),
              12.h,
              AppTextField(controller: nameController, hintText: 'Имя'),
              12.h,
              AppTextField(controller: passwordController, hintText: 'Пароль'),
              12.h,
              AppTextField(controller: confirmPasswordController, hintText: 'Повторите пароль'),
              Align(alignment: Alignment.topRight, child: TextButton(onPressed: () {}, child: const Text('Забыли пароль?'))),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppButton(text: 'Зарегистрироваться'),
              10.h,
              TextButton(onPressed: _toLogin, child: const Text('Войти')),
            ],
          ),
        ),
      );
}
