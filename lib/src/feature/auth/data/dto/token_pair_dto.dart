import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_pair_dto.freezed.dart';
part 'token_pair_dto.g.dart';

@freezed
///
class TokenPairDto with _$TokenPairDto {
  ///
  const factory TokenPairDto({
    @JsonKey(name: 'access_token') required String access,
    @JsonKey(name: 'refresh_token')required String refresh,
  }) = _TokenPairDto;

  TokenPairDto._();

  ///
  factory TokenPairDto.fromJson(Map<String, Object?> json) =>
      _$TokenPairDtoFromJson(json);


}