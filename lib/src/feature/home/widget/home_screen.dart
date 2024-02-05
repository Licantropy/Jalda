import 'package:flutter/material.dart';
import 'package:jalda/src/core/utils/extensions/num_extensions.dart';
import 'package:jalda/src/feature/app/widget/app_button.dart';
import 'package:jalda/src/feature/home/widget/orders_scope.dart';
import 'package:jalda/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

/// {@template sample_page}
/// SamplePage widget
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro sample_page}
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

    const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
    const CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    final state = OrdersScope.stateOf(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Material(
                elevation: 10,
                shape: const CircleBorder(),
                child: Padding(padding: 13.p, child: const Icon(Icons.pin_drop)),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: GestureDetector(
                onTap: () => DependenciesScope.of(context).tokenManager.deleteTokens(),
                child: Material(
                  elevation: 10,
                  shape: const CircleBorder(),
                  child: Padding(padding: 13.p, child: const Icon(Icons.menu)),
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              child: SafeArea(
                child: Container(
                  margin: 10.p,
                  padding: 10.vp,
                  decoration: BoxDecoration(borderRadius: 25.r, color: Theme.of(context).colorScheme.primary),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [const Text('Почасово'), 20.w, const Text('Посуточно')],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
