import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_dto.freezed.dart';

part 'application_dto.g.dart';

@freezed
class ApplicationDto with _$ApplicationDto {
  const factory ApplicationDto({
    required int id,
    @JsonKey(name: 'owner_id') required int ownerId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'property_id') required int propertyId,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') required String endDate,
    @JsonKey(name: 'order_status') required String orderStatus,
    @JsonKey(name: 'is_completed') required int isCompleted,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _ApplicationDto;


  ///
  factory ApplicationDto.fromJson(Map<String, dynamic> json) => _$ApplicationDtoFromJson(json);

  static List<ApplicationDto> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map<ApplicationDto>((jsonItem) => ApplicationDto.fromJson(jsonItem as Map<String, dynamic>)).toList();
}
