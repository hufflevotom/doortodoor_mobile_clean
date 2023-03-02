import 'package:domain/src/folios/folios.dart';

class Folios {
  const Folios({
    this.id,
    this.numeroFolio,
    this.ruta,
    this.detailClient,
    this.detailDelivery,
    this.detailRequest,
    this.localSourcing,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  final String? id;
  final String? numeroFolio;
  final String? ruta;
  final CustomerDetail? detailClient;
  final DeliveryDetail? detailDelivery;
  final RequestDetail? detailRequest;
  final LocalSourcing? localSourcing;
  final Status? status;
  final String? createdAt;
  final String? updatedAt;
}
