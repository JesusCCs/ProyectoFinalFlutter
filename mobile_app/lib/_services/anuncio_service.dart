import 'package:mobile_app/_models/anuncio.dart';
import 'package:mobile_app/_services/storage_service.dart';
import '_base.dart';

abstract class AnuncioService {

  /// Comprueba si el usuario tiene un anuncio disponible por ver
  static Future<Anuncio?> getAnuncio() async {
    final id = await StorageService.getId();

    final response = await Base.dio.get('/anuncios/disponible');

    // Hay que tener en cuenta que si no hay anuncios disponibles se
    // nos enviará un 204 (No Content)
    if (response.statusCode != 200) return null;

    return Anuncio.fromJson(response.data);
  }

  /// Manda aviso al servidor de que el usuario acaba de ver el anuncio
  static Future<void> anucioVisto(String anuncioId) async {
    final id = await StorageService.getId();

    final response = await Base.dio.put('/anuncios/');

  }
}