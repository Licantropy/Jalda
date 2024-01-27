import 'dart:async';

import 'package:jalda/src/core/utils/preferences_dao.dart';

///
abstract interface class TokenManagerDataSource {
  ///
  FutureOr<void> saveAccessToken(String value);

  ///
  FutureOr<void> saveRefreshToken(String value);

  ///
  FutureOr<String?> getAccessToken();

  ///
  FutureOr<String?> getRefreshToken();
}

///
final class TokenManagerDataSourceImpl extends PreferencesDao implements TokenManagerDataSource {
  ///
  TokenManagerDataSourceImpl({required super.sharedPreferences});

  PreferencesEntry<String> get _access => stringEntry('access_token');

  PreferencesEntry<String> get _refresh => stringEntry('refresh_token');

  @override
  Future<void> saveAccessToken(String value) => _access.set(value);

  @override
  Future<void> saveRefreshToken(String value) => _refresh.set(value);


  @override
  Future<String?> getAccessToken() async => _access.read();

  @override
  Future<String?> getRefreshToken() async => _refresh.read();

}
