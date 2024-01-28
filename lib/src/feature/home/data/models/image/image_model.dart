import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.freezed.dart';

part 'image_model.g.dart';

@freezed
class ImageModel with _$ImageModel {
  const factory ImageModel({
    required int id,
    @JsonKey(name: 'property_id') required int propertyId,
    @JsonKey(name: 'photo_url') required String photoUrl,
  }) = _ImageModel;

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);
}
