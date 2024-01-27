import 'dart:async';
import 'package:jalda/src/feature/home/data/dto/flat_dto.dart';

///
abstract interface class OrdersDataSource {
  ///
  FutureOr<List<FlatDto>> getDailyOrders();
  ///
  FutureOr<List<FlatDto>> getHourlyOrders();
}
