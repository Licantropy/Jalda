import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/feature/home/data/dto/flat/flat_dto.dart';
import 'package:jalda/src/feature/home/data/models/image/image_model.dart';
import 'package:jalda/src/feature/home/data/models/landlord/landlord_model.dart';

part 'flat_model.freezed.dart';

enum AvailabilityStatus {
  @JsonKey(name: 'busy')
  busy,
  @JsonKey(name: 'free')
  free;
}

@freezed
///
 class FlatModel with _$FlatModel {
  ///
  const factory FlatModel({
    required int id,
    required String name,
    required String address,
    required double longitude,
    required double latitude,
    required int rooms,
    required int floor,
    required AvailabilityStatus status,
    required List<ImageModel> images,
     required LandlordModel landlord,
    String? description,
     String? priceHour,
    String? priceDay,
  }) = _FlatModel;

  static AvailabilityStatus _statusFromString(String statusString) {
    switch (statusString) {
      case 'busy':
        return AvailabilityStatus.busy;
      case 'free':
        return AvailabilityStatus.free;
      default:
        throw ArgumentError('Unknown availability status: $statusString');
    }
  }

  factory FlatModel.fromDto(FlatDto dto) =>
      FlatModel(
        id: dto.id,
        name: dto.name,
        description: dto.description,
        address: dto.address,
        landlord: LandlordModel.fromDto(dto.landlord),
        longitude: dto.longitude,
        latitude: dto.latitude,
        priceHour: dto.priceHour.toString(),
        priceDay: dto.priceDay.toString(),
        rooms: dto.rooms,
        floor: dto.floor,
        status: _statusFromString(dto.availabilityStatus),
        images: dto.images
            .map((e) =>
            ImageModel(
              id: e.id,
              propertyId: e.propertyId,
              imageUrl: e.imageUrl,
            ))
            .toList(),
      );
}
