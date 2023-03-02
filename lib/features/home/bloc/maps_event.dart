part of 'maps_bloc.dart';

abstract class MapsEvent extends Equatable {
  const MapsEvent();
  @override
  List<Object> get props => [];
}

class ChangeThemeMap extends MapsEvent {
  const ChangeThemeMap();
}

class HandlePermissionLocation extends MapsEvent {
  const HandlePermissionLocation();
}

class HandlePermissionGPS extends MapsEvent {
  const HandlePermissionGPS();
}
