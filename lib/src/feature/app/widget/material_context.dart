import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jalda/src/core/localization/localization.dart';
import 'package:jalda/src/feature/auth/login/widget/login_screen.dart';
import 'package:jalda/src/feature/auth/registration/widget/registration_screen.dart';
import 'package:jalda/src/feature/auth/widget/auth_scope.dart';
import 'package:jalda/src/feature/home/widget/home_screen.dart';
import 'package:jalda/src/feature/settings/widget/settings_scope.dart';

/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatelessWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeOf(context).theme;
    final locale = SettingsScope.localeOf(context).locale;
    final _router = GoRouter(
      routes: [
        GoRoute(
          name: 'login',
          path: '/',
          builder: (context, state) => const AuthScope(child: LoginScreen()),
          routes: [
            GoRoute(
              name: 'registration',
              path: 'registration',
              builder: (context, state) => const AuthScope(child: RegistrationScreen()),
            ),
          ],
        ),
        GoRoute(name: 'home', path: '/home', builder: (context, state) => const HomeScreen()),
      ],
    );

    return MaterialApp.router(
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.mode,
      localizationsDelegates: Localization.localizationDelegates,
      supportedLocales: Localization.supportedLocales,
      locale: locale,
      routerConfig: _router,
    );
  }
}
