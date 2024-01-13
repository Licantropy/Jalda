import 'dart:async';
import 'package:jalda/src/feature/auth/data/dto/token_pair_dto.dart';
import 'package:jalda/src/feature/auth/data/params/login_params.dart';
import 'package:jalda/src/feature/auth/data/params/registration_params.dart';

///
abstract interface class AuthDataSource {
  ///
  FutureOr<TokenPairDto> login({required LoginParams params});

  ///
  FutureOr<TokenPairDto> register({required RegistrationParams params});
}
