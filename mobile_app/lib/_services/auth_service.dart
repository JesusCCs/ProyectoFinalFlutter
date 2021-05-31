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


  static Future<bool> create(username, email, pass, confirmPass) async {
    var response = await Base.dio.post('/usuarios', data: {
      'UserName': username,
      'Email': email,
      'Password' : pass,
      'ConfirmedPassword': confirmPass
    }).catchError((e) => print(e));

    return response.statusCode == 200;
  }
}
