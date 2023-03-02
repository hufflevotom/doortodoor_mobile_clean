class DeliveryDetail {
  const DeliveryDetail({
    this.id,
    this.fechaEntrega,
    this.deliveryLocation,
    this.ordenEntrega,
    this.visitingHours,
  });

  final String? id;
  final String? fechaEntrega;
  final DeliveryLocation? deliveryLocation;
  final int? ordenEntrega;
  final VisitingHours? visitingHours;
}

class DeliveryLocation {
  const DeliveryLocation({
    this.id,
    this.latitud,
    this.longitud,
    this.distrito,
  });
  final String? id;
  final String? latitud;
  final String? longitud;
  final String? distrito;
}

class VisitingHours {
  const VisitingHours({
    this.id,
    this.inicioVisita,
    this.finvisita,
  });
  final String? id;
  final int? inicioVisita;
  final int? finvisita;
}
