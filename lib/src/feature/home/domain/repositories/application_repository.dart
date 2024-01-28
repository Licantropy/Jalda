import 'package:jalda/src/feature/home/data/models/application/application_model.dart';
import 'package:jalda/src/feature/home/data/params/application_params.dart';
import 'package:jalda/src/feature/home/data/sources/application_data_source_impl.dart';

///
class ApplicationRepository {
  final ApplicationDataSourceImpl _dataSource;

  ///
  ApplicationRepository(this._dataSource);

  ///
  Future<List<ApplicationModel>> getApplications() async {
    final dtoList = await _dataSource.getApplications();
    return dtoList.map((dto) => ApplicationModel.fromDto(dto)).toList();
  }


  Future<ApplicationModel> createApplication(ApplicationParams params) async {
    final dto = await _dataSource.createApplication(params);
    return ApplicationModel.fromDto(dto);
  }
}
