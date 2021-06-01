import 'package:dio/dio.dart';
import 'package:mobile_app/_services/error_service.dart';

import '_base.dart';

abstract class AuthService {

  static Future<bool> login(String email, String pass) async {
    var response = await Base.dio.post('/usuarios/login', data: {
      'UserNameOrEmail': email,
      'Password': pass
    }).catchError((e) => ErrorService.dio(e));

    return response.statusCode == 200;
  }

  static Future<void> forgot(String email) async {
    await Base.dio.post('/auth/forgot-password', data: {
      'Email': email
    }).catchError((e) => ErrorService.dio(e));
  }


  static Future<bool> create(username, email, pass, confirmPass) async {
    var response = await Base.dio.post('/usuarios', data: {
      'UserName': username,
      'Email': email,
      'Password' : pass,
      'ConfirmedPassword': confirmPass
    }).catchError((e) => ErrorService.dio(e));

    return response.statusCode == 200;
  }
}
