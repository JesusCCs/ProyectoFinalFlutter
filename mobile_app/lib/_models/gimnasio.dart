import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Clase para enapsular toda la información que el servidor manda cuando
/// se requiren todos los gimnaios a mostrar en la pantalla del listado
class GimnasioList {
  String id;
  String logo;
  String nombre;
  String descripcion;
  dynamic tarifa;

  GimnasioList({required this.id,
    required this.logo,
    required this.nombre,
    required this.descripcion,
    required this.tarifa});

  /// Método para parsear desde el json que nos llega del servidor a un objeto
  factory GimnasioList.fromJson(Map<String, dynamic> json) {
    return GimnasioList(
        id: json['id'],
        logo: json['logo'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
        tarifa: json['tarifa']);
  }

  /// Método de apoyo para mostrar la descripción hasta donde se pueda
  /// (máx. 4 líneas configuradas, que es el tamaño donde se ve adecuadamente para
  /// el tamaño de la carta).
  /// Si el parámetro que recibe no es nulo, se marca de color distintivo
  /// Esto se hace así, porque lo que reciba será las búsqueda que el usuario
  /// escribe en el filtro de Descripción
  Widget description(String descriptionSearch) {
    if (descriptionSearch == '') return Text(
      descripcion,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14.0,
        color: Colors.black54,
      ),
    );

    return RichText(
        text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black54,
            ),
          children: <TextSpan>[
            TextSpan(),
            TextSpan(),
            TextSpan(),
          ]
        )
    );
  }
}

/// Clase que encapsula todos los parámetros que devuelve el servidor al requerir
/// los detalles de un gimansio en concreto cuando se va a la pantalla de Detalles
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

  /// Contructor que genera el objeto a partir del json que recibimos desde el servidor
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
