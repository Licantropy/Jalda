import 'package:flutter/material.dart';
import 'package:jalda/src/feature/app/widget/material_context.dart';
import 'package:jalda/src/feature/initialization/model/dependencies.dart';
import 'package:jalda/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:jalda/src/feature/settings/widget/settings_scope.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// {@template app}
/// [App] is an entry point to the application.
///
/// All the global scopes should be defined there.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({required this.result, super.key});

  /// Running this function will result in attaching
  /// corresponding [RenderObject] to the root of the tree.
  void attach([VoidCallback? callback]) {
    callback?.call();
    runApp(this);
  }

  /// The initialization result from the [InitializationProcessor]
  final InitializationResult result;

  @override
  Widget build(BuildContext context) => DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: DependenciesScope(
          dependencies: result.dependencies,
          child: const SettingsScope(child: MaterialContext()),
        ),
      );
}
