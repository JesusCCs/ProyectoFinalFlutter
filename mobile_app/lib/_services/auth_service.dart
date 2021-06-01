import 'package:dio/dio.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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


  static Future<bool> create(Map<String, FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>> inputs) async {
    var response = await Base.dio.post('/usuarios', data: {
      'UserName': inputs["UserName"]!.value,
      'Email': inputs["Email"]!.value,
      'Password' : inputs["Password"]!.value,
      'ConfirmedPassword': inputs["ConfirmedPassword"]!.value
    }).catchError((e) => ErrorService.dio(e));

    return response.statusCode == 200;
  }
}
