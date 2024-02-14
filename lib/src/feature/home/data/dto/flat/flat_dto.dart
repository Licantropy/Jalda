import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/feature/home/data/dto/image/image_dto.dart';

part 'flat_dto.freezed.dart';

part 'flat_dto.g.dart';

@freezed
class FlatDto with _$FlatDto {
  const factory FlatDto({
    required int id,
    required String name,
    required String address,
    required double longitude,
    required double latitude,
    required int rooms,
    required int floor,
    required List<ImageDto> images,
    String? description,
    @JsonKey(name: 'price_hour') int? priceHour,
    @JsonKey(name: 'price_day') int? priceDay,
    @JsonKey(name: 'availability_status') required String availabilityStatus,
  }) = _FlatDto;

  ///
  factory FlatDto.fromJson(Map<String, dynamic> json) => _$FlatDtoFromJson(json);

  static List<FlatDto> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map<FlatDto>((jsonItem) => FlatDto.fromJson(jsonItem as Map<String, dynamic>)).toList();
}
