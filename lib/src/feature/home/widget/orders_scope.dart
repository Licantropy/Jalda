import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalda/src/core/utils/extensions/context_extension.dart';
import 'package:jalda/src/feature/home/bloc/orders_bloc.dart';
import 'package:jalda/src/feature/initialization/widget/dependencies_scope.dart';

abstract class OrdersScopeController {
  void fetchDailyFlats();

  void fetchHourlyFlats();

  void fetchSingleFlat(int id);
}

class OrdersScope extends StatefulWidget {
  const OrdersScope({required this.child, super.key});

  final Widget child;

  static OrdersScopeController of(BuildContext context, {bool listen = true}) =>
      context.inhOf<_InheritedOrdersScope>(listen: listen).controller;

  static OrdersState stateOf(BuildContext context) => context.inhOf<_InheritedOrdersScope>().state;

  @override
  State<OrdersScope> createState() => _OrdersScopeState();
}

class _OrdersScopeState extends State<OrdersScope> implements OrdersScopeController {
  late final OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();
    _ordersBloc = OrdersBloc(DependenciesScope.of(context).flatRepository);
  }

  @override
  void dispose() {
    _ordersBloc.close();
    super.dispose();
  }

  @override
  void fetchDailyFlats() => _ordersBloc.add(const FetchDailyFlats());

  @override
  void fetchHourlyFlats() => _ordersBloc.add(const FetchHourlyFlats());

  @override
  void fetchSingleFlat(int id) => _ordersBloc.add(FetchSingleFlat(id));

  @override
  Widget build(BuildContext context) => BlocBuilder<OrdersBloc, OrdersState>(
        bloc: _ordersBloc,
        builder: (context, state) => _InheritedOrdersScope(
          state: state,
          controller: this,
          child: widget.child,
        ),
      );
}

class _InheritedOrdersScope extends InheritedWidget {
  final OrdersState state;
  final OrdersScopeController controller;

  const _InheritedOrdersScope({
    required this.state,
    required this.controller,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedOrdersScope oldWidget) => oldWidget.state != state;
}
