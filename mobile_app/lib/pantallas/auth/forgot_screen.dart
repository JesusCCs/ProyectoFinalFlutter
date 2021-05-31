import 'package:flutter/material.dart';
import 'package:mobile_app/_componentes/form_button.dart';
import 'package:mobile_app/_componentes/input_field.dart';
import 'package:mobile_app/_componentes/navigation_link.dart';
import 'package:mobile_app/pantallas/auth/login_screen.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  "No te preocupes,",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Dinos tu email y podrás recuperar tu cuenta",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(.6),
                  ),
                )),
            SizedBox(height: screenHeight * .07),
            InputField(
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            SizedBox(height: screenHeight * .025),
            SizedBox(height: screenHeight * .075),
            FormButton(text: "Recuperar"),
            SizedBox(height: screenHeight * .05),
            NavigationLink(text: 'Iniciar Sesión', screen: LoginScreen())
          ],
        ),
      ),
    );
  }
}
