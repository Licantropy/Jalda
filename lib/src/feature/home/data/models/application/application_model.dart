import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/feature/home/data/dto/application/application_dto.dart';

part 'application_model.freezed.dart';

@freezed
class ApplicationModel with _$ApplicationModel {
  const factory ApplicationModel({
    required int id,
    required int ownerId,
    required int userId,
    required int propertyId,
    required String startDate,
    required String endDate,
    required String orderStatus,
    required int isCompleted,
    required String createdAt,
    required String updatedAt,
  }) = _ApplicationModel;

  factory ApplicationModel.fromDto(ApplicationDto dto) => ApplicationModel(
      id: dto.id,
      ownerId: dto.ownerId,
      userId: dto.userId,
      propertyId: dto.propertyId,
      startDate: dto.startDate,
      endDate: dto.endDate,
      orderStatus: dto.orderStatus,
      isCompleted: dto.isCompleted,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt);
}
