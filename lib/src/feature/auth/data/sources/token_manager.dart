import 'dart:async';

import 'package:jalda/src/core/utils/preferences_dao.dart';

///
abstract interface class ITokenManager {
  ///
  FutureOr<void> saveAccessToken(String value);

  ///
  FutureOr<void> saveRefreshToken(String value);

  ///
  FutureOr<String?> getAccessToken();

  ///
  FutureOr<String?> getRefreshToken();

  ///
  FutureOr<void> deleteTokens();
}

///
final class TokenManagerImpl extends PreferencesDao implements ITokenManager {
  ///
  TokenManagerImpl({required super.sharedPreferences});

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

  @override
  Future<void> deleteTokens() async {
    await _access.remove();
    await _refresh.remove();
  }
}
