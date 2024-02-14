import 'package:freezed_annotation/freezed_annotation.dart';

part 'landlord_dto.freezed.dart';

part 'landlord_dto.g.dart';

@freezed
class LandlordDto with _$LandlordDto {
  const factory LandlordDto({
    required int id,
    required String name,
    required String phone,
    required String image,
  }) = _LandlordDto;

  factory LandlordDto.fromJson(Map<String, dynamic> json) => _$LandlordDtoFromJson(json);
}
