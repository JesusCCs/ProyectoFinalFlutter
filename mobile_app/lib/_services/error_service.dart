

import 'package:dio/dio.dart';

abstract class ErrorService {

  static List<Error> errors = new List<Error>.empty();

  static dio(DioError e) {

    if (e.response == null) {
      add(new Map.fromEntries([
        new MapEntry('general', ['Error al intentar conectarse con el servidor'])
      ]));

      return;
    }

    if (e.response!.statusCode == 500) {
      add(new Map.fromEntries([
        new MapEntry('general', ['Error interno del servidor'])
      ]));

      return;
    }

    if (e.response!.statusCode == 400) {
      print('ERROR 400');
      print(e.response!.data['errors'] is Map);
      add(e.response!.data['errors']);
      print('BUENA');
      return;
    }


  }

  static clear() {
    errors.clear();
  }

  static showInForm() {
    if (errors.isEmpty) return;

    print(errors.first.message);
  }

  static void add(Map<String, List<String>> newErrors) {
    newErrors.forEach((key, value) {
      ErrorService.errors.add(new Error(key, value.first));
    });
  }
}

class Error {
  Error(String key, String message);

  String get key => this.key;
  String get message => this.message;
}