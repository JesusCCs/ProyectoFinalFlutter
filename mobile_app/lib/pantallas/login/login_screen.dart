import 'package:flutter/material.dart';
import 'package:mobile_app/_componentes/form_button.dart';
import 'package:mobile_app/_componentes/input_field.dart';
import 'package:mobile_app/_componentes/navigation_link.dart';
import 'package:mobile_app/pantallas/register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function(String email, String password)? onSubmitted;

  LoginScreen({this.onSubmitted});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  "Bienvenido,",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Inicia sesión para continuar",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(.6),
                  ),
                )),
            SizedBox(height: screenHeight * .07),
            InputField(
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: screenHeight * .05),
            InputField(
              labelText: "Contraseña",
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: NavigationLink(
                  text: '¿Olvidaste la contraseña?', screen: RegisterScreen()),
            ),
            SizedBox(height: screenHeight * .075),
            FormButton(text: "Iniciar sesión"),
            SizedBox(height: screenHeight * .05),
            NavigationLink(text: 'Registrarme', screen: RegisterScreen())
          ],
        ),
      ),
    );
  }
}
