import 'package:domain/src/folios/folios.dart';

abstract class FoliosRepository {
  Future<List<Folios>> getFolios(String ruta);
  Future<Map<String, String>> uploadImages({
    required String imageClient,
    required String imageGuide,
    required String imagePlace,
  });
  Future<bool> saveEvidence({
    required String urlClient,
    required String urlGuide,
    required String urlPlace,
    required String idResponsable,
    required String idFolio,
    required String estado,
  });
  Future<bool> saveJustification({
    required String justification,
    required String idFolio,
    required String idResponsable,
    required String estado,
  });
  Future<bool> saveReport({
    required String finality,
    required String idResponsable,
    required String idFolio,
  });
}
