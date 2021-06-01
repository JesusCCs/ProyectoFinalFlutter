import 'package:dio/dio.dart';

abstract class Base {
  static const URL = "https://localhost:5001"; // "https://10.0.2.2:5001"

  static Dio dio = Dio(new BaseOptions(
    baseUrl: URL
  ));

  static init() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          print("REQUEST---");
          print(options.uri.authority);
          return handler.next(options);
        },
        onResponse:(response,handler) {
          print("RESPONSE--");
          print(response.data);
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          print("ERROR--");
          print(e.response);
          return  handler.next(e);
        }
    ));
  }
}