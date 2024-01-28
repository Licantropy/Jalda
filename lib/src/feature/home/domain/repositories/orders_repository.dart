import 'package:jalda/src/feature/home/data/models/flat_model.dart';
import 'package:jalda/src/feature/home/data/models/image_model.dart';
import 'package:jalda/src/feature/home/data/sources/orders_data_source_impl.dart';

///
class OrdersRepository {
  final OrdersDataSourceImpl _dataSource;

  ///
  OrdersRepository(this._dataSource);

  ///
  Future<List<FlatModel>> getDailyOrders() async {
    final dtoList = await _dataSource.getDailyOrders();
    return dtoList.map((dto) => FlatModel.fromDto(dto)).toList();
  }

  ///
  Future<List<FlatModel>> getHourlyFlats() async {
    throw UnimplementedError();
  }
}
