import 'package:mobile_app/_models/gimnasio.dart';
import '_base.dart';

abstract class AuthService {

  static Future<bool> login(String email, String pass) async {
    var response = await Base.dio.post('/usuarios/login', data: {
      'UserNameOrEmail': email,
      'Password': pass
    }).catchError((e) => print(e));

    print(response.data);

    return response.statusCode == 200;
  }



}
