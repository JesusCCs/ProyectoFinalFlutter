/// Encapsulación de los parámetros del anuncio
/// Tiene varias constantes para evitar el uso de literales a la hora de
/// conocer la naturaleaza del anuncio.
///
/// Los estados que posee son los mínimos necesarios para que el ciclo de visualización
/// y aviso al servidor de dicha visualización se complete. Esto es,
/// la ruta y el tipo para saber que Widget mostrar en la vista, si Imagen o Video
/// y el id del anuncio para dar parte al backend de qué anuncio se ha visitado
class Anuncio {

  static const IMAGEN = 'imagen';
  static const GIF = 'gif';
  static const VIDEO = 'video';

  String id;
  String ruta;
  String tipo;

  Anuncio({required this.id, required this.ruta, required this.tipo});

  factory Anuncio.fromJson(Map<String, dynamic> json) {
    return Anuncio(id: json['id'], ruta: json['recurso'], tipo: json['tipo']);
  }
}
