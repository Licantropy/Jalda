import 'dart:async';

import 'package:dio/dio.dart';
import 'package:jalda/src/feature/auth/data/sources/auth_data_source_impl.dart';
import 'package:jalda/src/feature/auth/data/sources/token_manager_source.dart';
import 'package:jalda/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:jalda/src/feature/initialization/model/initialization_progress.dart';
import 'package:jalda/src/feature/settings/data/locale_datasource.dart';
import 'package:jalda/src/feature/settings/data/settings_repository.dart';
import 'package:jalda/src/feature/settings/data/theme_datasource.dart';
import 'package:jalda/src/feature/settings/data/theme_mode_codec.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A function which represents a single initialization step.
typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

/// The initialization steps, which are executed in the order they are defined.
///
/// The [Dependencies] object is passed to each step, which allows the step to
/// set the dependency, and the next step to use it.
mixin InitializationSteps {
  /// The initialization steps,
  /// which are executed in the order they are defined.
  final initializationSteps = <String, StepAction>{
    'Shared Preferences': (progress) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      progress.dependencies.sharedPreferences = sharedPreferences;
    },
    'Rest client': (progress) async {
      final restClientDio = Dio(
        BaseOptions(
          baseUrl: '',
        ),
      );
      restClientDio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );

      progress.dependencies.restClientDio = restClientDio;
    },
    'Settings Repository': (progress) {
      final sharedPreferences = progress.dependencies.sharedPreferences;
      final themeDataSource = ThemeDataSourceImpl(
        sharedPreferences: sharedPreferences,
        codec: const ThemeModeCodec(),
      );
      final localeDataSource = LocaleDataSourceImpl(
        sharedPreferences: sharedPreferences,
      );
      progress.dependencies.settingsRepository = SettingsRepositoryImpl(
        themeDataSource: themeDataSource,
        localeDataSource: localeDataSource,
      );
    },
    'Auth Repository': (progress) async {
      final authDataSource = AuthDataSourceImpl(progress.dependencies.restClientDio);
      final tokenManagerDataSource = TokenManagerDataSourceImpl(sharedPreferences: progress.dependencies.sharedPreferences);

      progress.dependencies.authRepository = AuthRepository(authDataSource, tokenManagerDataSource);
    },
  };
}
