import 'package:flutter/material.dart';
import 'package:mobile_app/pantallas/auth/login_screen.dart';

import '_services/_base.dart';

void main() {
  Base.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    return new LoginScreen();
  }
}
