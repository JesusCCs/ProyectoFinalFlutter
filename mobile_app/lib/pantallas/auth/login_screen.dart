import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mobile_app/_componentes/form_button.dart';
import 'package:mobile_app/_componentes/navigation_link.dart';
import 'package:mobile_app/_services/auth_service.dart';
import 'package:mobile_app/_services/error_service.dart';
import 'package:mobile_app/pantallas/auth/forgot_screen.dart';
import 'package:mobile_app/pantallas/auth/register_screen.dart';
import 'package:mobile_app/pantallas/listado/listado_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  String? _passError;
  String? _emailError;
  bool _customErrors = false;

  submit() async {
    final isValid = _formKey.currentState!.saveAndValidate();

    if (!isValid && !_customErrors) return;

    setState(() => {
          _customErrors = false,
          _passError = null,
          _emailError = null,
        });

    ErrorService.clear();

    final email = _formKey.currentState!.fields['UserNameOrEmail']!.value;
    final pass = _formKey.currentState!.fields['Password']!.value;

    final isLogged = await AuthService.login(email, pass);

    if (!isLogged) {
      var dynamicErrors =
          ErrorService.showGeneralAndGetDynamic(context, form: _formKey);

      if (dynamicErrors != null) {
        setState(() => {
              _passError = dynamicErrors[0],
              _emailError = dynamicErrors[1],
              _customErrors = true
            });
      }

      return;
    }

    FocusScope.of(context).unfocus();

    _formKey.currentState!.reset();

    Navigator.push(context, MaterialPageRoute(builder: (_) => ListadoScreen()));
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
                  name: 'UserNameOrEmail',
                  decoration: InputDecoration(
                      labelText: 'Usuario o Email', errorText: _emailError),
                  keyboardType: TextInputType.emailAddress,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 3)
                  ])),
              SizedBox(height: screenHeight * .05),
              FormBuilderTextField(
                  name: 'Password',
                  decoration: InputDecoration(
                      labelText: 'Contraseña', errorText: _passError),
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
