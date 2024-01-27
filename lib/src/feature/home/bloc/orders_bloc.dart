import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/feature/home/data/models/flat_model.dart';
import 'package:jalda/src/feature/home/domain/repositories/orders_repository.dart';

part 'orders_event.dart';

part 'orders_state.dart';

part 'orders_bloc.freezed.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository _flatRepository;

  OrdersBloc(this._flatRepository) : super(const OrdersState.initial()) {
    on<FetchDailyFlats>(_onFetchDailyFlats);
    on<FetchHourlyFlats>(_onFetchHourlyFlats);
  }

  Future<void> _onFetchDailyFlats(FetchDailyFlats event, Emitter<OrdersState> emit) async {
    try {
      emit(const OrdersState.loading());
      final flat = await _flatRepository.getDailyOrders();
      emit(OrdersState.success(flat));
    } catch (e) {
      emit(OrdersState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> _onFetchHourlyFlats(FetchHourlyFlats event, Emitter<OrdersState> emit) async {
    try {
      emit(const OrdersState.loading());
      final flat = await _flatRepository.getHourlyFlats();
      emit(OrdersState.success(flat));
    } catch (e) {
      emit(OrdersState.error(e.toString()));
      rethrow;
    }
  }
}
