part of 'orders_bloc.dart';

@freezed
sealed class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = _Initial;

  const factory OrdersState.loading() = _Loading;

  const factory OrdersState.success(List<FlatModel> flat) = _Success;

  const factory OrdersState.error(String message) = _Error;
}
