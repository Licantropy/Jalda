import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';

part 'auth_model.g.dart';

///
@freezed
class AuthModel with _$AuthModel {
  ///
  factory AuthModel({
    required String token,
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _AuthModel;

  AuthModel._();

  ///
  factory AuthModel.fromJson(Map<String, Object?> json) => _$AuthModelFromJson(json);
}
