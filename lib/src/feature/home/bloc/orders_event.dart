part of 'orders_bloc.dart';

@freezed
class OrdersEvent with _$OrdersEvent {
  const factory OrdersEvent.started() = _Started;

  const factory OrdersEvent.fetchDailyFlats() = FetchDailyFlats;

  const factory OrdersEvent.fetchHourlyFlats() = FetchHourlyFlats;

  const factory OrdersEvent.fetchSingleFlat(int id) = FetchSingleFlat;
}
