// ignore_for_file: use_decorated_box

import 'dart:async';
import 'dart:developer';

import 'package:doortodoor_app/app/config/app_colors.dart';
import 'package:doortodoor_app/features/home/bloc/maps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHome extends StatefulWidget {
  const MapHome({super.key});

  @override
  State<MapHome> createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  final Completer<GoogleMapController> _controller = Completer();
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  /*  final Set<Polyline> polylines = {
    if (mapBloc.locationFolio != null)
      Polyline(
        polylineId: const PolylineId('1'),
        points: [
          mapBloc.locationUser!,
          mapBloc.locationFolio!,
        ],
        color: Colors.red,
        width: 5,
      ),
  }; */

  Future<void> _goToTheLakeUser() async {
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: context.read<MapsBloc>().state.locationUser!,
          zoom: 15,
        ),
      ),
    );
  }

  Future<void> _goToZoomOrLessMap(bool isZoom) async {
    if (isZoom) {
      final controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.zoomIn(),
      );
      return;
    } else {
      final controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.zoomOut(),
      );
      return;
    }
  }

  Future<void> _goToPaintPolylines(
    double originLatitude,
    double originLongitude,
    double destLatitude,
    double destLongitude,
  ) async {
    final result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyC6USsxj2-wP_fJSjSMnqAR8zNZsNuY0yA',
      PointLatLng(originLatitude, originLongitude),
      PointLatLng(destLatitude, destLongitude),
    );
    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (final point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  void _addPolyLine() {
    const id = PolylineId('poly');
    final polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      width: 2,
      points: polylineCoordinates,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mapBloc = context.watch<MapsBloc>().state;
    return Stack(
      children: [
        GoogleMap(
          polylines: Set<Polyline>.of(polylines.values),
          compassEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          markers: {
            Marker(
              onTap: () {
                _controller.future.then((value) {
                  value.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: mapBloc.locationUser!,
                        zoom: 15,
                      ),
                    ),
                  );
                });
              },
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
              markerId: const MarkerId('1'),
              position: mapBloc.locationUser!,
              infoWindow: const InfoWindow(
                title: 'Repartidor',
                snippet: 'Origen',
              ),
            ),
            if (mapBloc.locationFolio != null)
              Marker(
                onTap: () {
                  _controller.future.then((value) {
                    value.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: mapBloc.locationFolio!,
                          zoom: 15,
                        ),
                      ),
                    );
                  });
                },
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen,
                ),
                markerId: const MarkerId('2'),
                position: mapBloc.locationFolio!,
                infoWindow: const InfoWindow(
                  title: 'Usuario',
                  snippet: 'Destino',
                ),
              ),
          },
          mapType: mapBloc.themeNormal ? MapType.normal : MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: mapBloc.locationUser!,
            zoom: 10,
          ),
          onMapCreated: _controller.complete,
        ),
        Positioned(
          bottom: 240,
          right: 10,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.azul_100,
                  AppColors.azul_100,
                ],
              ),
            ),
            child: IconButton(
              constraints: const BoxConstraints(
                maxHeight: 40,
                maxWidth: 40,
              ),
              onPressed: () {
                _goToPaintPolylines(
                  mapBloc.locationUser!.latitude,
                  mapBloc.locationUser!.longitude,
                  mapBloc.locationFolio!.latitude,
                  mapBloc.locationFolio!.longitude,
                );
              },
              icon: const Icon(
                // Brujula
                Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          top: 140,
          right: 10,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.azul_100,
                  AppColors.azul_100,
                ],
              ),
            ),
            child: IconButton(
              constraints: const BoxConstraints(
                maxHeight: 40,
                maxWidth: 40,
              ),
              onPressed: _goToTheLakeUser,
              icon: const Icon(
                Icons.gps_fixed,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Positioned(
        //   bottom: 250,
        //   right: 10,
        //   child: Container(
        //     decoration: const BoxDecoration(
        //       borderRadius: BorderRadius.all(
        //         Radius.circular(10),
        //       ),
        //       color: Colors.red,
        //     ),
        //     child: IconButton(
        //       constraints: const BoxConstraints(
        //         maxHeight: 40,
        //         maxWidth: 40,
        //       ),
        //       onPressed: () => _goToZoomOrLessMap(false),
        //       icon: const Icon(
        //         Icons.remove,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
        // Positioned(
        //   bottom: 200,
        //   right: 10,
        //   child: Container(
        //     decoration: const BoxDecoration(
        //       borderRadius: BorderRadius.all(
        //         Radius.circular(10),
        //       ),
        //       color: Colors.red,
        //     ),
        //     child: IconButton(
        //       constraints: const BoxConstraints(
        //         maxHeight: 40,
        //         maxWidth: 40,
        //       ),
        //       onPressed: () => _goToZoomOrLessMap(true),
        //       icon: const Icon(
        //         Icons.add,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}


  /*  return Stack(
      children: [
        GoogleMap(
          myLocationEnabled: true,
          markers: {
            Marker(
              onTap: () {
                _controller.future.then((value) {
                  value.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: mapBloc.locationUser!,
                        zoom: 15,
                      ),
                    ),
                  );
                });
              },
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
              markerId: const MarkerId('1'),
              position: mapBloc.locationUser!,
              infoWindow: const InfoWindow(
                title: 'Repartidor',
                snippet: 'Origen',
              ),
            ),
            if (mapBloc.locationFolio != null)
              Marker(
                onTap: () {
                  _controller.future.then((value) {
                    value.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: mapBloc.locationFolio!,
                          zoom: 15,
                        ),
                      ),
                    );
                  });
                },
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen,
                ),
                markerId: const MarkerId('2'),
                position: mapBloc.locationFolio!,
                infoWindow: const InfoWindow(
                  title: 'Usuario',
                  snippet: 'Destino',
                ),
              ),
          },
          mapType: mapBloc.themeNormal ? MapType.normal : MapType.satellite,
          initialCameraPosition: CameraPosition(
            target: mapBloc.locationUser!,
            zoom: 10,
            //zoom: 10,
          ),
          onMapCreated: _controller.complete,
        ),
        Positioned(
          top: 60,
          child: GestureDetector(
            onTap: () => _goToZoomOrLessMap(true),
            child: Container(
              color: Colors.red,
              height: 30,
              width: 30,
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 40,
          child: GestureDetector(
            onTap: () => _goToZoomOrLessMap(false),
            child: Container(
              color: Colors.blue,
              height: 30,
              width: 30,
            ),
          ),
        ),
      ],
    );
  } */
