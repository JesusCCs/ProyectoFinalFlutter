import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/_componentes/form_button.dart';
import 'package:mobile_app/_componentes/input_field.dart';
import 'package:mobile_app/_componentes/navigation_link.dart';
import 'package:mobile_app/pantallas/login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final Function(String email, String password)? onSubmitted;

  RegisterScreen({this.onSubmitted});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String email, password, confirmPassword;
  late String emailError, passwordError;

  Function(String email, String password)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    email = "";
    password = "";
    confirmPassword = "";

    emailError = "";
    passwordError = "";
  }

  void resetErrorText() {
    setState(() {
      emailError = "";
      passwordError = "";
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = "Email is invalid";
      });
      isValid = false;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        passwordError = "Please enter a password";
      });
      isValid = false;
    }
    if (password != confirmPassword) {
      setState(() {
        passwordError = "Passwords do not match";
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() {
    if (validate()) {
      onSubmitted!(email, password);
    }
  }

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
                  "Crear cuenta,",
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
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              labelText: "Contraseña",
              obscureText: true,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              labelText: "Repetir contraseña",
              obscureText: true,
            ),
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
