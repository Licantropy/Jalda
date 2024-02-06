import 'package:flutter/material.dart';
import 'package:jalda/src/core/utils/extensions/context_extension.dart';
import 'package:jalda/src/core/utils/extensions/num_extensions.dart';

abstract class ErrorScopeController {
  void showErrorSnackBar(String error);
}

class ErrorScope extends StatefulWidget {
  final Widget child;

  const ErrorScope({required this.child, super.key});

  static ErrorScopeController of(BuildContext context) => context.inhOf<_InheritedErrorScope>().controller;

  @override
  State<ErrorScope> createState() => _ErrorScopeState();
}

class _ErrorScopeState extends State<ErrorScope> implements ErrorScopeController {
  @override
  Widget build(BuildContext context) => _InheritedErrorScope(controller: this, child: widget.child);

  @override
  void showErrorSnackBar(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.background,
        duration: const Duration(seconds: 3),
        margin: 20.p,
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent),
            15.w,
            Expanded(child: Text(error, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600))),
          ],
        ),
      ),
    );
  }
}

class _InheritedErrorScope extends InheritedWidget {
  final ErrorScopeController controller;

  const _InheritedErrorScope({required this.controller, required super.child});

  @override
  bool updateShouldNotify(_InheritedErrorScope oldWidget) => false;
}
