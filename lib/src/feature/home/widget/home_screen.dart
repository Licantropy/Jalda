import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jalda/src/feature/home/data/models/flat/flat_model.dart';
import 'package:jalda/src/feature/home/widget/custom_tab_bar.dart';
import 'package:jalda/src/feature/home/widget/orders_scope.dart';
import 'package:jalda/src/feature/initialization/widget/dependencies_scope.dart';

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
  Set<Marker> _markers = {};

  Iterable<Marker> _generateMarkers(List<FlatModel> flats) sync* {
    for (final flat in flats) {
      yield Marker(
        markerId: MarkerId(flat.id.toString()),
        position: LatLng(flat.latitude, flat.longitude),
        infoWindow: InfoWindow(title: flat.name, snippet: flat.address),
      );
    }
  }

  static const CameraPosition _kAlmaty = CameraPosition(target: LatLng(43.2220, 76.8512), zoom: 10);

  static const List<String> tabNames = ['Почасово', 'Посуточно'];

  void deleteTokens() => DependenciesScope.of(context).tokenManager.deleteTokens();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    OrdersScope.stateOf(context).mapOrNull(success: (state) => _markers = _generateMarkers(state.flat).toSet());
  }

  @override
  Widget build(BuildContext context) {
    final List<VoidCallback> tabCallbacks = [
      () => OrdersScope.of(context).fetchHourlyFlats(),
      () => OrdersScope.of(context).fetchDailyFlats(),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          GoogleMap(
            markers: _markers,
            mapType: MapType.normal,
            initialCameraPosition: _kAlmaty,
            onMapCreated: (GoogleMapController controller) => _controller.complete(controller),
            padding: const EdgeInsets.only(bottom: 40, right: 10),
          ),

          /// temporary plug
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(onTap: deleteTokens, child: Container(height: 50, width: 50, color: Colors.redAccent)),
          ),
          SafeArea(child: CustomTabBar(tabNames: tabNames, tabCallbacks: tabCallbacks)),
        ],
      ),
    );
  }
}
