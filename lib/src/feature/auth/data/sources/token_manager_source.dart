import 'dart:async';

import 'package:jalda/src/core/utils/preferences_dao.dart';



///
abstract interface class TokenManagerDataSource {
  ///
  FutureOr<void> saveAccessToken(String value);
}



///
class TokenManagerDataSourceImpl extends TokenManagerDataSource {
  final PreferencesDao _preferencesDao;

  ///
  TokenManagerDataSourceImpl(this._preferencesDao);

  @override
  Future<void> saveAccessToken(String value) async {
    await _preferencesDao.stringEntry('access_token').set(value);
  }

  ///
  Future<String?> getAccessToken() async => _preferencesDao.stringEntry('access_token').read();
}