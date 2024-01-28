import 'dart:async';
import 'package:jalda/src/feature/home/data/dto/application/application_dto.dart';
import 'package:jalda/src/feature/home/data/params/application_params.dart';

///
abstract interface class ApplicationDataSource {
  ///
  FutureOr<List<ApplicationDto>> getApplications();
  ///
  FutureOr<ApplicationDto> createApplication(ApplicationParams params);
}
