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
