import 'package:flutter/material.dart';
import 'package:mobile_app/pantallas/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return new MaterialApp(
      title: 'Sweet',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: new AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new LoginScreen(
      onSubmitted: (String email, String password) {
        print(email);
        print(password);
      },
    );
  }
}
