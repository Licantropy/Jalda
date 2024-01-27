import 'package:dio/dio.dart';
import 'package:jalda/src/feature/auth/data/sources/token_manager_source.dart';
import 'package:jalda/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:jalda/src/feature/home/domain/repositories/orders_repository.dart';
import 'package:jalda/src/feature/settings/data/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template dependencies}
/// Dependencies container
/// {@endtemplate}
base class Dependencies {
  /// {@macro dependencies}
  Dependencies();

  /// Shared preferences
  late final SharedPreferences sharedPreferences;

  /// Token manager
  late final TokenManagerDataSourceImpl tokenManagerDataSource;

  /// Rest client
  late final Dio restClientDio;

  /// Theme repository
  late final SettingsRepository settingsRepository;

  /// AuthRepository
  late final AuthRepository authRepository;

  /// OrdersRepository
  late final OrdersRepository ordersRepository;
}

/// {@template initialization_result}
/// Result of initialization
/// {@endtemplate}
final class InitializationResult {
  /// {@macro initialization_result}
  const InitializationResult({
    required this.dependencies,
    required this.stepCount,
    required this.msSpent,
  });

  /// The dependencies
  final Dependencies dependencies;

  /// The number of steps
  final int stepCount;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() => '$InitializationResult('
      'dependencies: $dependencies, '
      'stepCount: $stepCount, '
      'msSpent: $msSpent'
      ')';
}
