import 'package:jalda/src/feature/auth/data/params/login_params.dart';
import 'package:jalda/src/feature/auth/data/params/registration_params.dart';
import 'package:jalda/src/feature/auth/data/sources/auth_data_source_impl.dart';
import 'package:jalda/src/feature/auth/data/sources/token_manager_source.dart';

///
class AuthRepository {
  final AuthDataSourceImpl _auth;
  final TokenManagerDataSource _tokenManager;

  ///
  AuthRepository(this._auth, this._tokenManager);

  ///
  Future<void> login(LoginParams params) async {
    final tokens = await _auth.login(params: params);

    await _tokenManager.saveAccessToken(tokens.access);
  }

  ///
  Future<void> register(RegistrationParams params) async {
    final tokens = await _auth.register(params: params);

    await _tokenManager.saveAccessToken(tokens.access);
  }
}
