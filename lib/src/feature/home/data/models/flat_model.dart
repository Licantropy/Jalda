import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/feature/home/data/dto/flat_dto.dart';
import 'package:jalda/src/feature/home/data/models/image_model.dart';

part 'flat_model.freezed.dart';

part 'flat_model.g.dart';

@freezed
class FlatModel with _$FlatModel {
  const factory FlatModel({
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
    @JsonKey(name: 'availability_status') required String availabilityStatus,
    required List<ImageModel> photos,
  }) = _FlatModel;

  factory FlatModel.fromDto(FlatDto dto) => FlatModel(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      address: dto.address,
      longitude: dto.longitude,
      latitude: dto.latitude,
      rooms: dto.rooms,
      floor: dto.floor,
      availabilityStatus: dto.availabilityStatus,
      photos: dto.photos.map((e) => ImageModel(
                id: e.id,
                propertyId: e.propertyId,
                photoUrl: e.photoUrl,
              ))
          .toList());
}
