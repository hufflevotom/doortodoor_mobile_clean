import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc(this._authBloc) : super(const MapsInitial()) {
    on<ChangeThemeMap>(_onChangeThemeMap);
    on<HandlePermissionLocation>(_onHandlePermissionLocation);
    on<HandlePermissionGPS>(_onHandlePermissionGPS);
  }

  final Location _location = Location();
  final AuthBloc _authBloc;

  void _onChangeThemeMap(ChangeThemeMap event, Emitter<MapsState> emit) {
    emit(
      ChangeThemeMapState(
        themeMap: !state.themeNormal,
        latLngUser: state.locationUser!,
        latLngFolio: state.locationFolio,
        permission: state.accessPermission!,
      ),
    );
  }

  Future<void> _onHandlePermissionGPS(
    HandlePermissionGPS event,
    Emitter<MapsState> emit,
  ) async {
    if (!await _location.serviceEnabled()) {
      if (!await _location.requestService()) {
        emit(const MapsGPSDenied());
        return;
      }
    }

    log('GPS: ${await _location.serviceEnabled()}');
    emit(const MapsGPSSuccess());
  }

  Future<void> _onHandlePermissionLocation(
    HandlePermissionLocation event,
    Emitter<MapsState> emit,
  ) async {
    final permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      if (await _location.requestPermission() == PermissionStatus.denied) {
        emit(const MapsPermissionDenied());
        return;
      }

      if (await _location.requestPermission() ==
          PermissionStatus.deniedForever) {
        emit(const MapsPermissionDeniedForever());
        return;
      }

      if (await _location.requestPermission() == PermissionStatus.granted) {
        await permissionGranted(emit);
      }

      if (await _location.requestPermission() ==
          PermissionStatus.grantedLimited) {
        await permissionGranted(emit);
      }
    } else {
      await permissionGranted(emit);
    }
  }

  Future<void> permissionGranted(Emitter<MapsState> emit) async {
    emit(const MapsLoading(themeNormal: true));
    final addressUser = await _location.getLocation();
    final authBloc = _authBloc.state.folios;
    if (authBloc!.isEmpty) {
      emit(
        MapsPermissionGranted(
          latLngUser: LatLng(addressUser.latitude!, addressUser.longitude!),
        ),
      );
    } else {
      final latitudeFolio =
          authBloc.first.detailDelivery?.deliveryLocation?.latitud;

      final longitudeFolio =
          authBloc.first.detailDelivery?.deliveryLocation?.longitud;

      emit(
        MapsPermissionGranted(
          latLngUser: LatLng(
            addressUser.latitude!,
            addressUser.longitude!,
          ),
          latLngFolio: LatLng(
            double.parse(latitudeFolio!),
            double.parse(longitudeFolio!),
          ),
        ),
      );
    }
  }
}
