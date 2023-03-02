import 'package:domain/src/auth/auth.dart';

class User {
  User({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.celular,
    required this.brevete,
    required this.documento,
    required this.dni,
    required this.idTipoRol,
    required this.contrasena,
    required this.createdAt,
    required this.updatedAt,
    required this.accessToken,
    this.vehicle,
    this.ruta,
    this.idResponsable,
  });
  final String id;
  final String nombre;
  final String apellidos;
  final String celular;
  final String brevete;
  final String documento;
  final String dni;
  final String idTipoRol;
  final String contrasena;
  final String createdAt;
  final String updatedAt;
  final String accessToken;
  final Vehicle? vehicle;
  final String? ruta;
  final String? idResponsable;
}
