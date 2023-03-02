part of 'maps_bloc.dart';

abstract class MapsState extends Equatable {
  const MapsState({
    required this.themeNormal,
    this.accessPermission,
    this.locationUser,
    this.locationFolio,
  });
  final bool themeNormal;
  final bool? accessPermission;
  final LatLng? locationUser;
  final LatLng? locationFolio;

  @override
  List<Object?> get props => [
        themeNormal,
        accessPermission,
        locationUser,
        locationFolio,
      ];
}

class MapsLoading extends MapsState {
  const MapsLoading({required super.themeNormal});
}

class MapsInitial extends MapsState {
  const MapsInitial()
      : super(
          themeNormal: true,
          accessPermission: false,
          locationUser: null,
          locationFolio: null,
        );
}

class ChangeThemeMapState extends MapsState {
  const ChangeThemeMapState({
    required this.themeMap,
    required this.permission,
    required this.latLngUser,
    this.latLngFolio,
  }) : super(
          themeNormal: themeMap,
          accessPermission: permission,
          locationUser: latLngUser,
          locationFolio: latLngFolio,
        );

  final bool themeMap;
  final LatLng latLngUser;
  final LatLng? latLngFolio;
  final bool permission;
}

class MapsPermissionDenied extends MapsState {
  const MapsPermissionDenied()
      : super(
          themeNormal: true,
          accessPermission: false,
          locationFolio: null,
          locationUser: null,
        );
}

class MapsGPSDenied extends MapsState {
  const MapsGPSDenied()
      : super(
          themeNormal: true,
          accessPermission: false,
          locationFolio: null,
          locationUser: null,
        );
}

class MapsGPSSuccess extends MapsState {
  const MapsGPSSuccess()
      : super(
          themeNormal: true,
          accessPermission: false,
          locationUser: null,
          locationFolio: null,
        );
}

class MapsPermissionDeniedForever extends MapsState {
  const MapsPermissionDeniedForever()
      : super(
          themeNormal: true,
          accessPermission: false,
          locationFolio: null,
          locationUser: null,
        );
}

class MapsPermissionGranted extends MapsState {
  const MapsPermissionGranted({
    required this.latLngUser,
    this.latLngFolio,
  }) : super(
          themeNormal: true,
          accessPermission: true,
          locationUser: latLngUser,
          locationFolio: latLngFolio,
        );

  final LatLng latLngUser;
  final LatLng? latLngFolio;
}
