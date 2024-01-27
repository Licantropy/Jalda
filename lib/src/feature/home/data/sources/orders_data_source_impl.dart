import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jalda/src/feature/home/data/dto/flat_dto.dart';
import 'package:jalda/src/feature/home/data/sources/orders_data_source.dart';

///
final class OrdersDataSourceImpl implements OrdersDataSource {
  final Dio _dio;
///
  OrdersDataSourceImpl(this._dio);



  @override
  Future<List<FlatDto>> getDailyOrders() async {
    try {
      final response = await _dio.get('client/daily');
      return FlatDto.fromJsonList(response.data['data'] as List<dynamic>);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  @override
  Future<List<FlatDto>> getHourlyOrders() {
    // TODO: implement getHourlyOrders
    throw UnimplementedError();
  }
  
}