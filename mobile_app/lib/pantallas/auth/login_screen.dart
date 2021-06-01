import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mobile_app/_componentes/form_button.dart';
import 'package:mobile_app/_componentes/navigation_link.dart';
import 'package:mobile_app/_services/auth_service.dart';
import 'package:mobile_app/pantallas/auth/forgot_screen.dart';
import 'package:mobile_app/pantallas/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  String? _emailError;

  submit() async {

    final isValid = _formKey.currentState!.saveAndValidate();

    if (!isValid) return;

    setState(() => _emailError = null);

    final email = _formKey.currentState!.fields['email']!.value;
    final pass = _formKey.currentState!.fields['pass']!.value;

    final isLogged = await AuthService.login(email, pass);



    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Bienvenido,",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
              FormBuilderTextField(
                  name: 'email',
                  decoration: InputDecoration(
                      labelText: 'Email', errorText: _emailError),
                  keyboardType: TextInputType.emailAddress,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(context),
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 3)
                  ])),
              SizedBox(height: screenHeight * .05),
              FormBuilderTextField(
                  name: 'pass',
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                  ),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 5)
                  ])),
              SizedBox(height: screenHeight * .015),
              Align(
                alignment: Alignment.centerRight,
                child: NavigationLink(
                    text: '¿Olvidaste la contraseña?', screen: ForgotScreen()),
              ),
              SizedBox(height: screenHeight * .075),
              FormButton(text: "Iniciar sesión", onPressed: () => submit()),
              SizedBox(height: screenHeight * .05),
              NavigationLink(text: 'Registrarme', screen: RegisterScreen())
            ],
          ),
        ),
      ),
    );
  }
}
