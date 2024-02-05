import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jalda/src/feature/initialization/model/dependencies.dart';
import 'package:jalda/src/feature/initialization/widget/dependencies_scope.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
      tokenCheck();
    super.initState();
  }

  /// temporary plug
  void tokenCheck() async {
    final tokenManager = DependenciesScope.of(context).tokenManager;
    final token = await tokenManager.getAccessToken();
    print("TOKEN: $token");
    token != null && token.isNotEmpty ? context.go('/home') : context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
