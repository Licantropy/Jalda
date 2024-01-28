import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jalda/src/feature/home/data/dto/application/application_dto.dart';
import 'package:jalda/src/feature/home/data/params/application_params.dart';
import 'package:jalda/src/feature/home/data/sources/application_data_source.dart';

///
final class ApplicationDataSourceImpl implements ApplicationDataSource {
  final Dio _dio;

  ///
  ApplicationDataSourceImpl(this._dio);

  @override
  Future<List<ApplicationDto>> getApplications() async {
    try {
      final response = await _dio.get('client/orders');
      return ApplicationDto.fromJsonList(response.data['data'] as List<dynamic>);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<ApplicationDto> createApplication(ApplicationParams params) async {
    try {
      final response = await _dio.post('client/orders', data: params.toData());
      return ApplicationDto.fromJson(response.data['data'] as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


}
