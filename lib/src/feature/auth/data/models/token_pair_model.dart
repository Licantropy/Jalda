import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/feature/auth/data/dto/token_pair_dto.dart';

part 'token_pair_model.freezed.dart';

part 'token_pair_model.g.dart';

///
@freezed
class TokenPairModel with _$TokenPairModel {
  ///
  factory TokenPairModel({
    required String accessToken,
    required String refreshToken,
  }) = _TokenPairModel;

  TokenPairModel._();

  ///
  factory TokenPairModel.fromDto(TokenPairDto dto) => TokenPairModel(accessToken: dto.accessToken, refreshToken: dto.refreshToken);
}
