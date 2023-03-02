import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

class HttpAuthRepository implements AuthRepository {
  const HttpAuthRepository(this._dio);
  final Dio _dio;

  @override
  Future<User> getUser(String token) async {
    try {
      const path = '/auth/login/token';
      final data = {'token': token};

      final response = await _dio.get<String>(path, queryParameters: data);
      if (response.statusCode == 200) {
        final data = json.decode(response.data!) as Map<String, dynamic>;
        return userFromMap(data);
      } else {
        final data = json.decode(response.data!) as Map<String, dynamic>;
        final message = data['message'] as String?;
        throw GetUserException(message ?? 'Error al obtener usuario');
      }
    } on GetUserException catch (e) {
      throw GetUserException(e.message);
    }
  }

  @override
  Future<String> signIn({required String dni, required String password}) async {
    try {
      const path = '/auth/login';
      final data = {
        'documento': dni,
        'contrasena': password,
      };

      final response = await _dio.post<String>(path, data: data);
      if (response.statusCode == 201) {
        final data = json.decode(response.data!) as Map<String, dynamic>;
        return data['access_token'] as String;
      } else {
        final data = json.decode(response.data!) as Map<String, dynamic>;
        final message = data['message'] as String?;
        throw SignInException(message ?? 'Error al Iniciar sesión');
      }
    } on SignInException catch (e) {
      throw SignInException(e.message);
    }
  }
}

User userFromMap(Map<String, dynamic> user) {
  return User(
    id: user['user']['_id'] as String,
    nombre: user['user']['nombre'] as String,
    apellidos: user['user']['apellidos'] as String,
    celular: user['user']['celular'] as String,
    brevete: user['user']['brevete'] as String,
    documento: user['user']['documento'] as String,
    dni: user['user']['dni'] as String,
    idTipoRol: user['user']['idTipoRol'] as String,
    contrasena: user['user']['contrasena'] as String,
    createdAt: user['user']['createdAt'] as String,
    updatedAt: user['user']['updatedAt'] as String,
    accessToken: user['access_token'] as String,
    idResponsable: user['user']['idResponsable'] as String?,
    ruta: user['user']['ruta'] as String?,
    vehicle: user['user']['idVehiculo'] != null
        ? vehicleFromMap(user['user']['idVehiculo'] as Map<String, dynamic>)
        : null,
  );
}

Vehicle vehicleFromMap(Map<String, dynamic> vehicle) {
  return Vehicle(
    id: vehicle['_id'] as String?,
    placa: vehicle['placa'] as String?,
    modelo: vehicle['modelo'] as String?,
  );
}
