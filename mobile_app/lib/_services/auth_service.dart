import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mobile_app/_services/error_service.dart';
import 'package:mobile_app/_services/storage_service.dart';

import '_base.dart';

abstract class AuthService {

  /// Realiza el login contra el servidor. Si se ejecuta
  /// correctamente setea los parámetros que devuelve éste que son los
  /// tokens de seguirdad y el id del usuario.
  static Future<bool> login(String email, String pass) async {
    var response = await Base.dio.post('/usuarios/login', data: {
      'UserNameOrEmail': email,
      'Password': pass
    }).catchError((e) => ErrorService.dio(e));

    if (response.statusCode != 200) return false;

    await StorageService.setSession(response.data);

    return true;
  }

  /// En caso de que el usuario olvide la contraseña, hay un sistema de
  /// recuperación de ésta.
  static Future<void> forgot(String email) async {
    await Base.dio.post('/auth/forgot-password', data: {
      'Email': email
    }).catchError((e) => ErrorService.dio(e));
  }

  /// Aquí es donde se envía la inforamación para que se dé de alta el usuario
  /// en la plataforma
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
