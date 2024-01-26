import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/feature/home/data/dto/image_dto.dart';

part 'flat_dto.freezed.dart';

part 'flat_dto.g.dart';

@freezed
class FlatDto with _$FlatDto {
  const factory FlatDto({
    required int id,
    required String name,
    required String description,
    required String address,
    required double longitude,
    required double latitude,
    required int rooms,
    required int floor,
    @JsonKey(name: 'price_hour') int? priceHour,
    @JsonKey(name: 'price_day') int? priceDay,
    required String availabilityStatus,
    required List<ImageDto> photos,
  }) = _FlatDto;

  ///
  factory FlatDto.fromJson(Map<String, dynamic> json) => _$FlatDtoFromJson(json);
}
