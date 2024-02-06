import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jalda/src/feature/home/data/models/flat/flat_model.dart';
import 'package:jalda/src/feature/home/widget/custom_tab_bar.dart';
import 'package:jalda/src/feature/home/widget/orders_scope.dart';

///
class HomeScreen extends StatefulWidget {
  ///
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => OrdersScope.of(context).fetchHourlyFlats());
  }

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final Set<Marker> _markers = {};

  void _createMarkers(List<FlatModel> flats) {
    _markers.clear();
    for (final flat in flats) {
      final marker = Marker(
        markerId: MarkerId(flat.id.toString()),
        position: LatLng(flat.longitude, flat.latitude),
        infoWindow: InfoWindow(title: flat.name, snippet: flat.address),
      );
      _markers.add(marker);
    }
  }

  static const CameraPosition _kAlmaty = CameraPosition(target: LatLng(43.2220, 76.8512), zoom: 10);

  static const List<String> tabNames = ['Почасово', 'Посуточно'];

  @override
  Widget build(BuildContext context) {
    final state = OrdersScope.stateOf(context);
    final List<VoidCallback> tabCallbacks = [
      () => OrdersScope.of(context).fetchHourlyFlats(),
      () => OrdersScope.of(context).fetchDailyFlats(),
    ];

    if (state.maybeMap(
      success: (state) {
        _createMarkers(state.flat);
        return true;
      },
      orElse: () => false,
    )) {}
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          GoogleMap(
            markers: _markers,
            mapType: MapType.hybrid,
            initialCameraPosition: _kAlmaty,
            onMapCreated: (GoogleMapController controller) => _controller.complete(controller),
            padding: const EdgeInsets.only(bottom: 40, right: 10),
          ),
          SafeArea(child: CustomTabBar(tabNames: tabNames, tabCallbacks: tabCallbacks)),
        ],
      ),
    );
  }
}
