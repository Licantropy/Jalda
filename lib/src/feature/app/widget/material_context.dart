import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jalda/src/core/localization/localization.dart';
import 'package:jalda/src/core/utils/error_scope.dart';
import 'package:jalda/src/feature/auth/login/widget/login_screen.dart';
import 'package:jalda/src/feature/auth/registration/widget/registration_screen.dart';
import 'package:jalda/src/feature/auth/widget/auth_scope.dart';
import 'package:jalda/src/feature/home/widget/home_screen.dart';
import 'package:jalda/src/feature/home/widget/orders_scope.dart';
import 'package:jalda/src/feature/settings/widget/settings_scope.dart';
import 'package:jalda/src/feature/splash/widget/splash_screen.dart';

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
        ShellRoute(builder: (context, state, child) => ErrorScope(child: child), routes: [
          GoRoute(path: '/', name: 'splash', builder: (context, state) => const SplashScreen()),
          ShellRoute(
            builder: (context, state, child) => AuthScope(child: child),
            routes: [
              GoRoute(name: 'login', path: '/login', builder: (context, state) => const LoginScreen(), routes: [
                GoRoute(
                  name: 'registration',
                  path: 'registration',
                  builder: (context, state) => const RegistrationScreen(),
                ),
              ]),
            ],
          ),
          GoRoute(name: 'home', path: '/home', builder: (context, state) => const OrdersScope(child: HomeScreen())),
        ])
      ],
    );

    return MaterialApp.router(
      theme: theme.lightTheme.copyWith(bottomSheetTheme: BottomSheetThemeData(surfaceTintColor: theme.lightTheme.scaffoldBackgroundColor)),
      darkTheme: theme.darkTheme,
      themeMode: theme.mode,
      localizationsDelegates: Localization.localizationDelegates,
      supportedLocales: Localization.supportedLocales,
      locale: locale,
      routerConfig: _router,
    );
  }
}
