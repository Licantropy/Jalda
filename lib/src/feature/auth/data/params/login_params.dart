import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/core/utils/params.dart';


part 'login_params.freezed.dart';

///
@unfreezed
class LoginParams with Params, _$LoginParams {

  ///
  factory LoginParams({
    required String email,
    required String password,
  }) = _LoginParams;

  LoginParams._();


  @override
  ///
  Map<String, dynamic> toData() => {
      'email': email,
      'password': password,
    };
}
