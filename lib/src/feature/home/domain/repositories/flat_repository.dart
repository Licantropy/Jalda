import 'package:jalda/src/feature/home/data/models/flat/flat_model.dart';
import 'package:jalda/src/feature/home/data/sources/flat_data_source_impl.dart';

///
class FlatRepository {
  final FlatDataSourceImpl _dataSource;

  ///
  FlatRepository(this._dataSource);

  ///
  Future<List<FlatModel>> getDailyFlats() async {
    final dtoList = await _dataSource.getDailyFlats();
    return dtoList.map((dto) => FlatModel.fromDto(dto)).toList();
  }

  ///
  Future<List<FlatModel>> getHourlyFlats() async {
    final dtoList = await _dataSource.getHourlyFlats();
    return dtoList.map((dto) => FlatModel.fromDto(dto)).toList();
  }

  ///
  Future<FlatModel> getFlatInfo(int id) async {
    final dto = await _dataSource.getFlatInfo(id);
    return FlatModel.fromDto(dto);
  }
}
