import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jalda/src/core/const/app_icons.dart';
import 'package:jalda/src/core/localization/localization.dart';
import 'package:jalda/src/core/utils/image_converter.dart';
import 'package:jalda/src/core/widgets%20/app_button.dart';
import 'package:jalda/src/feature/home/data/models/flat/flat_model.dart';
import 'package:jalda/src/feature/home/widget/custom_tab_bar.dart';
import 'package:jalda/src/feature/home/widget/flat_details_dialog.dart';
import 'package:jalda/src/feature/home/widget/orders_scope.dart';
import 'package:jalda/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:jalda/src/feature/settings/widget/settings_scope.dart';

///
class HomeScreen extends StatefulWidget {
  ///
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  Set<Marker> _markers = {};

  static const CameraPosition _kAlmaty = CameraPosition(target: LatLng(43.2220, 76.8512), zoom: 10);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchHourlyFlats());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateMarkersOnStateChange();
  }

  void _fetchHourlyFlats() => OrdersScope.of(context).fetchHourlyFlats();

  void _updateMarkersOnStateChange() => OrdersScope.stateOf(context)
      .mapOrNull(success: (state) async => _markers = await _generateMarkers(state.flat).whenComplete(() => setState(() {})));

  Future<Set<Marker>> _generateMarkers(List<FlatModel> flats) async {
    final Uint8List redPinBytes = await convertImageToUint8List(AppIcons.redPin);
    final Uint8List greenPinBytes = await convertImageToUint8List(AppIcons.greenPin);

    return flats.map((flat) {
      final Uint8List markerIconBytes = flat.status == AvailabilityStatus.busy ? redPinBytes : greenPinBytes;
      return _createMarker(flat, markerIconBytes);
    }).toSet();
  }

  Marker _createMarker(FlatModel flat, Uint8List markerIconBytes) => Marker(
        markerId: MarkerId(flat.id.toString()),
        position: LatLng(flat.latitude, flat.longitude),
        icon: BitmapDescriptor.fromBytes(markerIconBytes),
        onTap: () => _showFlatDetailsDialog(flat),
      );

  void _showFlatDetailsDialog(FlatModel flat) => FlatDetailsDialogWidget.show(context, flat);

  void _deleteTokens() => DependenciesScope.of(context).tokenManager.deleteTokens();

  @override
  Widget build(BuildContext context) {
    final List<String> tabNames = [
      Localization.of(context).hourly,
      Localization.of(context).daily,
    ];

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
            initialCameraPosition: _kAlmaty,
            onMapCreated: (GoogleMapController controller) => _controller.complete(controller),
            padding: const EdgeInsets.only(bottom: 40, right: 10),
          ),

          /// temporary plug
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(
              onTap: _deleteTokens,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    text: 'en',
                    onPressed: () => SettingsScope.of(context).setLocale(Locale('en')),
                  ),
                  AppButton(
                    text: 'ru',
                    onPressed: () => SettingsScope.of(context).setLocale(Locale('ru')),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: Image.asset(AppIcons.greenPin),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(child: CustomTabBar(tabNames: tabNames, tabCallbacks: tabCallbacks)),
        ],
      ),
    );
  }
}
