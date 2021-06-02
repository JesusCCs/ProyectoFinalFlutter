import 'package:flutter/material.dart';
import 'package:flutter_form_builder/localization/form_builder_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/_services/storage_service.dart';
import 'package:mobile_app/pantallas/auth/login_screen.dart';
import 'package:mobile_app/pantallas/listado/listado_screen.dart';

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
      supportedLocales: [
        Locale('es')
      ],
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: new AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      checkLogin();
    });
  }

  Future<void> checkLogin() async {
    final id = await StorageService.getId();
    print('ID: ' + (id ?? '0'));

    if (id != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ListadoScreen()));
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return SpinKitRipple(
      color: Colors.deepOrange,
      size: 300.0,
    );
  }
}