import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/core/utils/params.dart';

part 'registration_params.freezed.dart';

///
@unfreezed
class RegistrationParams with Params, _$RegistrationParams {
  ///
  factory RegistrationParams({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
    String? lastName,
  }) = _RegistrationParams;

  RegistrationParams._();

  @override

  ///
  Map<String, dynamic> toData() => {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'role': role,
        'last_name': lastName,
      };
}
