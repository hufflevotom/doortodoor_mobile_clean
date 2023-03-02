part of 'folios_bloc.dart';

@immutable
abstract class FoliosEvent {
  const FoliosEvent();
}

class ReportProblem extends FoliosEvent {
  const ReportProblem({
    required this.justification,
    required this.idFolio,
    required this.idResponsable,
  });
  final String justification;
  final String idFolio;
  final String idResponsable;
}

class FinalizeDelivery extends FoliosEvent {
  const FinalizeDelivery({
    required this.customerPhoto,
    required this.guidePhoto,
    required this.photoOfPlace,
    required this.idResponsable,
    required this.idFolio,
    required this.estado,
  });
  final File customerPhoto;
  final File guidePhoto;
  final File photoOfPlace;
  final String idResponsable;
  final String idFolio;
  final String estado;
}

class FinishDeliveryWithJustification extends FoliosEvent {
  const FinishDeliveryWithJustification({
    required this.justification,
    required this.idFolio,
    required this.idResponsable,
    required this.estado,
  });
  final String justification;
  final String idFolio;
  final String idResponsable;
  final String estado;
}
