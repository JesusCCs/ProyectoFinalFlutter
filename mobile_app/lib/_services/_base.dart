import 'package:dio/dio.dart';
import 'package:mobile_app/_services/storage_service.dart';

/// Clase con un solo estado estático que es el objeto que es capaz de realizar
/// las peticiones al servidor.
///
/// Además de ese objeto estático tiene una constante donde se indica la url a
/// la que hay que apuntar. Al estar usando un emulador de android, esta
/// URL debe ser 10.0.2.2, que es la que apunta al localhost del ordenador
/// en el que se ejecuta el emulador. El puerto es el mismo que si estuviesemos
/// en el propio local, luego no hay variación ahí.
abstract class Base {
  static const URL = "http://10.0.2.2:57976";

  static Dio dio = Dio(new BaseOptions(baseUrl: URL));

  /// Método que se debe llamar al inciio de la app para añadir los interceptores
  /// al objeto Dio. La intención era tener un sistema de tokens y refresh tokens
  /// tal y como se ha logrado en el proyecto de Angular
  static init() {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      print("REQUEST---");
      print(options.uri);

      // Se mantiene el sistema de enviar token de seguridad, aunque no es necesario
      // * ver nota de más abajo, en 'onError' *
      await setToken(options);

      return handler.next(options);
    }, onResponse: (response, handler) {
      print("RESPONSE--");
      print(response.data);

      return handler.next(response);
    }, onError: (DioError e, handler) async {
      print("ERROR--");
      print(e.response);

      // Aquí tendría que haber sistema de Refresh Tokens. Por falta de tiempo
      // se abandona esa funcionalidad y el backend está marcado en permitir
      // anónimante

      return handler.next(e);
    }));
  }

  /// Método cuya intención era realizar una nueva petición con la anterior
  /// que se había rechazado al caducarse el token. Ahora mismo no tiene uso
  static Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final token = await StorageService.getAccessToken();

    if (token != null) {
      requestOptions.headers["Authorization"] = "Bearer " + token;
    }

    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return Base.dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  /// Método de soporte para setear la autorización
  static Future<void> setToken(RequestOptions options) async {
    final token = await StorageService.getAccessToken();

    if (token != null) {
      options.headers["Authorization"] = "Bearer " + token;
    }
  }
}
