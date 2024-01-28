import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jalda/src/feature/home/data/dto/flat/flat_dto.dart';
import 'package:jalda/src/feature/home/data/sources/flat_data_source.dart';

///
final class FlatDataSourceImpl implements FlatDataSource {
  final Dio _dio;

  ///
  FlatDataSourceImpl(this._dio);

  @override
  Future<List<FlatDto>> getDailyFlats() async {
    try {
      final response = await _dio.get('client/daily');
      return FlatDto.fromJsonList(response.data['data'] as List<dynamic>);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<FlatDto>> getHourlyFlats() async {
    try {
      final response = await _dio.get('client/hourly');
      return FlatDto.fromJsonList(response.data['data'] as List<dynamic>);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<FlatDto> getFlatInfo(int id) async {
    try {
      final response = await _dio.get('client/show/$id');
      return FlatDto.fromJson(response.data['data'] as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
