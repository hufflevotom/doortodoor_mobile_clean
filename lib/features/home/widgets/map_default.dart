import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDefault extends StatelessWidget {
  const MapDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GoogleMap(
            scrollGesturesEnabled: false,
            zoomGesturesEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(-12.046374, -77.042793),
              zoom: 10,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.6),
            child: const Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
                radius: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
