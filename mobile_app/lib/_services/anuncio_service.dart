import 'package:mobile_app/_models/anuncio.dart';
import 'package:mobile_app/_services/error_service.dart';
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
  /// No importa la respuesta en este caso. Al usuario en la app no le
  /// afecta que en el servidor se haya gestionado bien la solicitud
  static Future<void> anucioVisto(String anuncioId) async {
    final id = await StorageService.getId();

    await Base.dio.put('/anuncios/$anuncioId/visto', data: {
      'UsuarioId': id
    }).catchError((e) => ErrorService.dio(e));

  }
}