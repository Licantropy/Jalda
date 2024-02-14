import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/feature/home/data/dto/image/image_dto.dart';

part 'image_model.freezed.dart';

@freezed
class ImageModel with _$ImageModel {
  const factory ImageModel({
    required int id,
    @JsonKey(name: 'property_id') required int propertyId,
    required String imageUrl,
  }) = _ImageModel;

  factory ImageModel.fromDto(ImageDto dto) => ImageModel(
        id: dto.id,
        propertyId: dto.propertyId,
        imageUrl: dto.imageUrl,
      );
}
