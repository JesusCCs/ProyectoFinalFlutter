import 'package:flutter/material.dart';
import 'package:flutter_form_builder/localization/form_builder_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/_services/storage_service.dart';
import 'package:mobile_app/pantallas/auth/login_screen.dart';
import 'package:mobile_app/pantallas/listado/listado_screen.dart';

import '_services/_base.dart';

Future<void> main() async {
  Base.init();
  dynamic id;

  try {
    id = await StorageService.getId();
  } catch(e) {
    id = null;
  }

  runApp(MyApp(id: id));
}

class MyApp extends StatelessWidget {

  final String? id;

  const MyApp({Key? key, this.id}) : super(key: key);


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
      debugShowCheckedModeBanner: false,
      home: AuthenticationWrapper(id: id),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {

  final String? id;
  const AuthenticationWrapper({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (id == null) {
      return LoginScreen();
    }

    return ListadoScreen();
  }
}