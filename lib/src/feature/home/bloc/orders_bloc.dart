import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jalda/src/feature/home/data/models/flat/flat_model.dart';
import 'package:jalda/src/feature/home/domain/repositories/flat_repository.dart';

part 'orders_event.dart';

part 'orders_state.dart';

part 'orders_bloc.freezed.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final FlatRepository _flatRepository;

  OrdersBloc(this._flatRepository) : super(const OrdersState.initial()) {
    on<FetchDailyFlats>(_onFetchDailyFlats);
    on<FetchHourlyFlats>(_onFetchHourlyFlats);
    on<FetchSingleFlat>(_onFetchSingleFlat);
  }

  Future<void> _onFetchDailyFlats(FetchDailyFlats event, Emitter<OrdersState> emit) async {
    try {
      emit(const OrdersState.loading());
      final flat = await _flatRepository.getDailyFlats();
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

  Future<void> _onFetchSingleFlat(FetchSingleFlat event, Emitter<OrdersState> emit) async {
    try {
      emit(const OrdersState.loading());
      final flat = await _flatRepository.getFlatInfo(event.id);
      emit(OrdersState.successFlat(flat));
    } catch (e) {
      emit(OrdersState.error(e.toString()));
      rethrow;
    }
  }
}
