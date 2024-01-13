import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalda/src/feature/auth/bloc/auth_bloc.dart';
import 'package:jalda/src/feature/initialization/widget/dependencies_scope.dart';


///
class AuthScope extends StatefulWidget {
  ///
  final Widget child;

  ///
  const AuthScope({required this.child, super.key});

  ///
  static AuthBloc authBlocOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_InheritedAuthScope>()!.authBloc;

  @override
  State<AuthScope> createState() => _AuthScopeState();
}

class _AuthScopeState extends State<AuthScope> {
  late final AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = AuthBloc(DependenciesScope.of(context).authRepository);
    super.initState();
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
      value: _authBloc,
      child: _InheritedAuthScope(
        authBloc: _authBloc,
        child: widget.child,
      ),
    );
}

class _InheritedAuthScope extends InheritedWidget {
  final AuthBloc authBloc;

  const _InheritedAuthScope({
    required super.child,
    required this.authBloc,
  });

  @override
  bool updateShouldNotify(_InheritedAuthScope oldWidget) => authBloc != oldWidget.authBloc;
}
