import 'package:flutter/material.dart';
import 'package:flutter_form_builder/localization/form_builder_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/_services/storage_service.dart';
import 'package:mobile_app/_themes/colors.dart';
import 'package:mobile_app/pantallas/anuncio_screen.dart';
import 'package:mobile_app/pantallas/auth/login_screen.dart';
import 'package:mobile_app/pantallas/listado/listado_screen.dart';

import '_services/_base.dart';

Future<void> main() async {
  Base.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String? id;

  const MyApp({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sweet',
      supportedLocales: [Locale('es')],
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: AuthenticatorWrapper()
    );
  }
}

class AuthenticatorWrapper extends StatefulWidget {
  @override
  _AuthenticatorWrapperState createState() => _AuthenticatorWrapperState();
}

class _AuthenticatorWrapperState extends State<AuthenticatorWrapper> {
  String? id;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getSession() async {
    id = await StorageService.getId();
    print("SESSION: $id");

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<bool>(
        future: getSession(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(color: Colors.white),
              child: SpinKitRipple(
                color: Colors.deepOrange,
                size: 300.0,
              ),
            );
          }

          return id == null ? LoginScreen() : AnuncioScreen();
        },
      ),
    );
  }
}
