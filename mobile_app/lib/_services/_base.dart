import 'package:dio/dio.dart';

abstract class Base {
  static const URL = "https://localhost:5001";

  static Dio dio = Dio(new BaseOptions(
    baseUrl: URL
  ));

  static init () => dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler){

        return handler.next(options);
      },
      onResponse:(response,handler) {

        return handler.next(response);
      },
      onError: (DioError e, handler) {

        return  handler.next(e);
      }
  ));
}