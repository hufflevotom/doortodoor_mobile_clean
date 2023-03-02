import 'package:doortodoor_app/app/config/app_colors.dart';
import 'package:doortodoor_app/features/home/bloc/maps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapGpsSuccess extends StatelessWidget {
  const MapGpsSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
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
          ),
          Positioned(
            top: 300,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 40,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Para poder usar la aplicación es necesario acceder a tu ubicación.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.azul_100),
                    ),
                    onPressed: () => context
                        .read<MapsBloc>()
                        .add(const HandlePermissionLocation()),
                    child: const Text('Permitir acceso'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
