import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/_componentes/form_button.dart';
import 'package:mobile_app/_componentes/input_field.dart';
import 'package:mobile_app/_componentes/navigation_link.dart';
import 'package:mobile_app/pantallas/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    // CoolAlert.show(
    //   context: context,
    //   type: CoolAlertType.success,
    //   title: "¡Cuenta creada!",
    //   text: "Ahora solo falta que confirmes tu email mediante el correo que te hemos enviado",
    // );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  "Crea una cuenta,",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Regístrate y podrás comenzar",
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
            InputField(
                labelText: "Contraseña",
                obscureText: true,
                controller: passwordController),
            SizedBox(height: screenHeight * .025),
            InputField(
                labelText: "Repetir contraseña",
                obscureText: true,
                controller: confirmPasswordController),
            SizedBox(height: screenHeight * .075),
            FormButton(text: "Registrarme"),
            SizedBox(height: screenHeight * .05),
            NavigationLink(text: 'Iniciar Sesión', screen: LoginScreen())
          ],
        ),
      ),
    );
  }
}
