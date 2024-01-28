import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/core/utils/params.dart';


part 'application_params.freezed.dart';

///
@unfreezed
class ApplicationParams with Params, _$ApplicationParams {

  ///
  ///
  factory ApplicationParams({
    required int propertyId,
    required DateTime startDate,
    required DateTime endDate,
  }) = _ApplicationParams;

  ApplicationParams._();


  @override
  ///
  Map<String, dynamic> toData() => {
    "property_id": propertyId,
    "start_date": startDate,
    "end_date": endDate
  };
}
