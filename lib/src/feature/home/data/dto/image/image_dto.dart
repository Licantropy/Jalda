import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_dto.freezed.dart';

part 'image_dto.g.dart';

@freezed
class ImageDto with _$ImageDto {
  const factory ImageDto({
    required int id,
    @JsonKey(name: 'property_id') required int propertyId,
    @JsonKey(name: 'photo_url') required String photoUrl,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _ImageDto;

  factory ImageDto.fromJson(Map<String, dynamic> json) => _$ImageDtoFromJson(json);
}
