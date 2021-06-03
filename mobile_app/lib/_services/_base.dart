import 'package:dio/dio.dart';
import 'package:mobile_app/_services/storage_service.dart';

import 'auth_service.dart';

abstract class Base {
  static const URL = "http://10.0.2.2:57976";

  static Dio dio = Dio(new BaseOptions(baseUrl: URL));

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

  static Future<void> setToken(RequestOptions options) async {
    final token = await StorageService.getAccessToken();

    if (token != null) {
      options.headers["Authorization"] = "Bearer " + token;
    }
  }
}
