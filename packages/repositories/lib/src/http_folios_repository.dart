import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;

// ignore_for_file: implicit_dynamic_parameter

class HttpFoliosRepository implements FoliosRepository {
  const HttpFoliosRepository(this._dio);
  final Dio _dio;

  @override
  Future<List<Folios>> getFolios(String ruta) async {
    try {
      final path = '/document/folios/ruta/$ruta';
      final response = await _dio.get<String>(path);
      if (response.statusCode == 200) {
        final data = json.decode(response.data!) as Map<String, dynamic>;
        final body = data['body'] as List<dynamic>;
        final folios = listFoliosFromMap(body);
        return folios;
      } else {
        final data = json.decode(response.data!) as Map<String, dynamic>;
        final message = data['message'] as String?;
        throw GetFoliosException(message ?? 'Error al obtener folios');
      }
    } on GetFoliosException catch (e) {
      throw GetFoliosException(e.message);
    }
  }

  @override
  Future<bool> saveEvidence({
    required String urlClient,
    required String urlGuide,
    required String urlPlace,
    required String idResponsable,
    required String idFolio,
    required String estado,
  }) async {
    try {
      const path = '/document/evidencias';
      final imagenes = [
        {'idTipoFoto': '60beeeb5030b61001519db57', 'urlFoto': urlClient},
        {'idTipoFoto': '60beeec7030b61001519db59', 'urlFoto': urlGuide},
        {'idTipoFoto': '60beeebc030b61001519db58', 'urlFoto': urlPlace}
      ];
      final body = {
        'idResponsable': idResponsable,
        'idFolio': idFolio,
        'idEstado': estado,
        'imagenes': imagenes,
      };
      final response = await _dio.post<String>(path, data: json.encode(body));
      final data = json.decode(response.data!) as Map<String, dynamic>;
      if (response.statusCode == 201) {
        return true;
      } else {
        final message = data['message'] as String?;
        throw SaveEvidenceException(message ?? 'Error al guardar evidencia');
      }
    } on SaveEvidenceException catch (e) {
      throw SaveEvidenceException(e.message);
    }
  }

  @override
  Future<bool> saveJustification({
    required String justification,
    required String idFolio,
    required String idResponsable,
    required String estado,
  }) async {
    try {
      const path = '/document/evidencias';
      final body = {
        'idResponsable': idResponsable,
        'idFolio': idFolio,
        'idEstado': estado,
        'justificacion': justification,
      };
      final response = await _dio.post<String>(path, data: json.encode(body));
      final data = json.decode(response.data!) as Map<String, dynamic>;
      if (response.statusCode == 201) {
        return true;
      } else {
        final message = data['message'] as String?;
        throw SaveJustificationException(
          message ?? 'Error al guardar justificacion',
        );
      }
    } on SaveJustificationException catch (e) {
      throw SaveJustificationException(e.message);
    }
  }

  @override
  Future<bool> saveReport({
    required String finality,
    required String idResponsable,
    required String idFolio,
  }) async {
    try {
      const path = '/document/evidencias/reportar';
      final body = {
        'justificacion': finality,
        'idResponsable': idResponsable,
        'idFolio': idFolio,
      };

      final response = await _dio.post<String>(path, data: body);
      if (response.statusCode == 201) {
        return true;
      } else {
        final data = json.decode(response.data!) as Map<String, dynamic>;
        final message = data['message'] as String?;
        throw SaveReportException(message ?? 'Error al reportar un problema');
      }
    } on SaveReportException catch (e) {
      throw SaveReportException(e.message);
    }
  }

  @override
  Future<Map<String, String>> uploadImages({
    required String imageClient,
    required String imageGuide,
    required String imagePlace,
  }) async {
    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/djgenjb9l/image/upload?upload_preset=uzguu8e0',
      );
      // Foto del Cliente
      final requestClient = http.MultipartRequest('POST', url);
      final fileClient = await http.MultipartFile.fromPath('file', imageClient);
      requestClient.files.add(fileClient);
      final streamClient = await requestClient.send();
      final responseClient = await http.Response.fromStream(streamClient);

      // Foto de la guía
      final requestGuide = http.MultipartRequest('POST', url);
      final fileGuide = await http.MultipartFile.fromPath('file', imageGuide);
      requestGuide.files.add(fileGuide);
      final streamGuide = await requestGuide.send();
      final responseGuide = await http.Response.fromStream(streamGuide);

      // Foto del lugar
      final requestPlace = http.MultipartRequest('POST', url);
      final filePlace = await http.MultipartFile.fromPath('file', imagePlace);
      requestPlace.files.add(filePlace);
      final streamPlace = await requestPlace.send();
      final responsePlace = await http.Response.fromStream(streamPlace);

      // Respuesta
      if (responseClient.statusCode != 200 &&
          responseClient.statusCode != 201) {
        throw const UploadImagesException('Error al subir la foto del cliente');
      }

      if (responseGuide.statusCode != 200 && responseGuide.statusCode != 201) {
        throw const UploadImagesException('Error al subir la foto de la guía');
      }

      if (responsePlace.statusCode != 200 && responsePlace.statusCode != 201) {
        throw const UploadImagesException('Error al subir la foto del lugar');
      }

      final dataClient =
          json.decode(responseClient.body) as Map<String, dynamic>;

      final dataGuide = json.decode(responseGuide.body) as Map<String, dynamic>;

      final dataPlace = json.decode(responsePlace.body) as Map<String, dynamic>;

      final urlClient = dataClient['secure_url'] as String;
      final urlGuide = dataGuide['secure_url'] as String;
      final urlPlace = dataPlace['secure_url'] as String;

      return {
        'urlClient': urlClient,
        'urlGuide': urlGuide,
        'urlPlace': urlPlace,
      };
    } on UploadImagesException catch (e) {
      throw UploadImagesException(e.toString());
    }
  }
}

List<Folios> listFoliosFromMap(List<dynamic> folios) {
  return folios.map((e) => foliosFromMap(e as Map<String, dynamic>)).toList();
}

Folios foliosFromMap(Map<String, dynamic> folios) {
  return Folios(
    id: folios['_id'] as String?,
    numeroFolio: folios['numeroFolio'] as String?,
    ruta: folios['ruta'] as String?,
    detailClient: folios['idDetalleCliente'] != null
        ? detailClientFromMap(
            folios['idDetalleCliente'] as Map<String, dynamic>)
        : null,
    detailDelivery: folios['idDetalleEntrega'] != null
        ? detailDeliveryFromMap(
            folios['idDetalleEntrega'] as Map<String, dynamic>)
        : null,
    detailRequest: folios['idDetallePedido'] != null
        ? detailRequestFromMap(
            folios['idDetallePedido'] as Map<String, dynamic>)
        : null,
    localSourcing: folios['idLocalAbastecimiento'] != null
        ? localSourcingFromMap(
            folios['idLocalAbastecimiento'] as Map<String, dynamic>)
        : null,
    status: folios['idEstado'] != null
        ? statusFromMap(folios['idEstado'] as Map<String, dynamic>)
        : null,
    createdAt: folios['createdAt'] as String?,
    updatedAt: folios['updatedAt'] as String?,
  );
}

CustomerDetail detailClientFromMap(Map<String, dynamic> map) {
  return CustomerDetail(
    id: map['_id'] as String?,
    nombre: map['nombre'] as String?,
    dni: map['dni'] as String?,
    telefono: map['telefono'] as String?,
    direccion: map['direccion'] as String?,
  );
}

DeliveryDetail detailDeliveryFromMap(Map<String, dynamic> map) {
  return DeliveryDetail(
    id: map['_id'] as String?,
    fechaEntrega: map['fechaEntrega'] as String?,
    deliveryLocation: map['idUbicacionEntrega'] != null
        ? deliveryLocationFromMap(
            map['idUbicacionEntrega'] as Map<String, dynamic>)
        : null,
    ordenEntrega: map['ordenEntrega'] as int?,
    visitingHours: map['idHorarioVisita'] != null
        ? visitingHoursFromMap(map['idHorarioVisita'] as Map<String, dynamic>)
        : null,
  );
}

DeliveryLocation deliveryLocationFromMap(Map<String, dynamic> map) {
  return DeliveryLocation(
    id: map['_id'] as String?,
    latitud: map['latitud'] as String?,
    longitud: map['longitud'] as String?,
    distrito: map['distrito'] as String?,
  );
}

VisitingHours visitingHoursFromMap(Map<String, dynamic> map) {
  return VisitingHours(
    id: map['_id'] as String?,
    inicioVisita: map['inicioVisita'] as int?,
    finvisita: map['finVisita'] as int?,
  );
}

RequestDetail detailRequestFromMap(Map<String, dynamic> map) {
  return RequestDetail(
    id: map['_id'] as String?,
    descripcionPedido: map['descripcionPedido'] as String?,
  );
}

LocalSourcing localSourcingFromMap(Map<String, dynamic> map) {
  return LocalSourcing(
    id: map['_id'] as String?,
    localAbastecimiento: map['localAbastecimiento'] as String?,
  );
}

Status statusFromMap(Map<String, dynamic> map) {
  return Status(
    id: map['_id'] as String?,
    estado: map['descripcion'] as String?,
  );
}
