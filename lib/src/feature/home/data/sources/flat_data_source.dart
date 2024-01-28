import 'dart:async';
import 'package:jalda/src/feature/home/data/dto/flat/flat_dto.dart';

///
abstract interface class FlatDataSource {
  ///
  FutureOr<List<FlatDto>> getDailyFlats();
  ///
  FutureOr<List<FlatDto>> getHourlyFlats();

  ///
  FutureOr<FlatDto> getFlatInfo(int id);
}
