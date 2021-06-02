class GimnasioList {
  String id;
  String logo;
  String nombre;
  String descripcion;
  dynamic tarifa;

  GimnasioList(
      {required this.id,
      required this.logo,
      required this.nombre,
      required this.descripcion,
      required this.tarifa});

  factory GimnasioList.fromJson(Map<String, dynamic> json) {
    return GimnasioList(
        id: json['id'],
        logo: json['logo'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
        tarifa: json['tarifa']);
  }
}

class GimnasioDetails {
  String id;
  String identificador;
  String logo;
  String nombre;
  String descripcion;
  String direccion;
  dynamic tarifa;

  GimnasioDetails({
    required this.id,
    required this.logo,
    required this.nombre,
    required this.descripcion,
    required this.tarifa,
    required this.identificador,
    required this.direccion,
  });

  factory GimnasioDetails.fromJson(Map<String, dynamic> json) {
    return GimnasioDetails(
        id: json['id'],
        logo: json['logo'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
        tarifa: json['tarifa'],
        identificador: json['identificador'],
        direccion: json['direccion']);
  }
}
