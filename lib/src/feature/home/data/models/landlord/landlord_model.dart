import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/feature/home/data/dto/landlord/landlord_dto.dart';

part 'landlord_model.freezed.dart';


@freezed
class LandlordModel with _$LandlordModel {
  const factory LandlordModel({
    required int id,
    required String name,
    required String phone,
    required String image,
  }) = _LandlordModel;

  factory LandlordModel.fromDto(LandlordDto dto) => LandlordModel(
        id: dto.id,
        name: dto.name,
        phone: dto.phone,
        image: dto.image,
      );
}
