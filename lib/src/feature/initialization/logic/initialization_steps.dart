import 'dart:async';

import 'package:dio/dio.dart';
import 'package:jalda/src/core/utils/interceptors.dart';
import 'package:jalda/src/feature/auth/data/sources/auth_data_source_impl.dart';
import 'package:jalda/src/feature/auth/data/sources/token_manager.dart';
import 'package:jalda/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:jalda/src/feature/home/data/sources/flat_data_source_impl.dart';
import 'package:jalda/src/feature/home/domain/repositories/flat_repository.dart';
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
    'Settings Repository': (progress) {
      final sharedPreferences = progress.dependencies.sharedPreferences;
      final themeDataSource = ThemeDataSourceImpl(sharedPreferences: sharedPreferences, codec: const ThemeModeCodec());
      final localeDataSource = LocaleDataSourceImpl(sharedPreferences: sharedPreferences);
      progress.dependencies.settingsRepository = SettingsRepositoryImpl(
        themeDataSource: themeDataSource,
        localeDataSource: localeDataSource,
      );
    },
    'Token Manager': (progress) async {
      final tokenManager = TokenManagerImpl(sharedPreferences: progress.dependencies.sharedPreferences);
      progress.dependencies.tokenManager = tokenManager;
    },
    'Rest client': (progress) async {
      final restClientDio = Dio(BaseOptions(baseUrl: progress.environmentStore.baseUrl));

      final settingsRepository = progress.dependencies.settingsRepository;

      restClientDio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

      restClientDio.interceptors.add(LanguageInterceptor(settingsRepository));

      progress.dependencies.restClientDio = restClientDio;
    },
    'Auth Repository': (progress) async {
      final authDataSource = AuthDataSourceImpl(progress.dependencies.restClientDio);

      progress.dependencies.authRepository = AuthRepository(authDataSource, progress.dependencies.tokenManager);

      progress.dependencies.restClientDio.interceptors
          .add(TokenInterceptor(progress.dependencies.tokenManager, progress.dependencies.authRepository));
    },
    'Flat Repository': (progress) async {
      final flatDataSource = FlatDataSourceImpl(progress.dependencies.restClientDio);

      progress.dependencies.flatRepository = FlatRepository(flatDataSource);
    },
  };
}
