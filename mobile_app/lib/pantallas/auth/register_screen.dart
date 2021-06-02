import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mobile_app/_componentes/form_button.dart';
import 'package:mobile_app/_componentes/navigation_link.dart';
import 'package:mobile_app/_services/auth_service.dart';
import 'package:mobile_app/_services/error_service.dart';
import 'package:mobile_app/pantallas/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  String? _userError;
  String? _emailError;
  String? _passError;
  String? _passConfirmError;
  bool _customErrors = false;

  submit() async {

    bool isValid = _formKey.currentState!.saveAndValidate();

    if (!isValid && !_customErrors) return;

    setState(() => {
      _customErrors = false,
      _userError = null,
      _emailError = null,
      _passError = null,
      _passConfirmError = null,
    });

    ErrorService.clear();

    final isCreated = await AuthService.create(_formKey.currentState!.fields);

    if (!isCreated) {
      var dynamicErrors = ErrorService.showGeneralAndGetDynamic(context, form: _formKey);

      if (dynamicErrors != null) {
        setState(() => {
          _userError = dynamicErrors[0],
          _emailError = dynamicErrors[1],
          _passError = dynamicErrors[2],
          _passConfirmError = dynamicErrors[3],
          _customErrors = true
        });
      }

      return;
    }

    FocusScope.of(context).unfocus();

    _formKey.currentState!.reset();

    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: "¡Cuenta creada!",
        text:
            "Ahora solo falta que confirmes tu email mediante el correo que te hemos enviado",
        onConfirmBtnTap: () => Navigator.push(context,MaterialPageRoute(
              builder: (_) => LoginScreen(),
            )));
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
                    "Crea una cuenta,",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Regístrate y podrás comenzar",
                    style: TextStyle(
                        fontSize: 18, color: Colors.black.withOpacity(.6)),
                  )),
              SizedBox(height: screenHeight * .07),
              FormBuilderTextField(
                  name: 'UserName',
                  decoration: InputDecoration(
                      labelText: 'Usuario', errorText: _userError),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 3)
                  ])),
              SizedBox(height: screenHeight * .025),
              FormBuilderTextField(
                  name: 'Email',
                  decoration: InputDecoration(
                      labelText: 'Email', errorText: _emailError),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 6),
                    FormBuilderValidators.email(context)
                  ])),
              SizedBox(height: screenHeight * .025),
              FormBuilderTextField(
                  name: 'Password',
                  decoration: InputDecoration(labelText: 'Contraseña', errorText: _passError),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 5),
                    (val) {
                      if (val !=
                          _formKey.currentState!.fields['ConfirmedPassword']!.value)
                        return 'Las contraseñas no coinciden';
                      return null;
                    }
                  ])),
              SizedBox(height: screenHeight * .025),
              FormBuilderTextField(
                  name: 'ConfirmedPassword',
                  decoration: InputDecoration(labelText: 'Repita la contraseña', errorText: _passConfirmError),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 5),
                    (val) {
                      if (val != _formKey.currentState!.fields['Password']!.value)
                        return 'Las contraseñas no coinciden';
                      return null;
                    }
                  ])),
              SizedBox(height: screenHeight * .075),
              FormButton(text: "Registrarme", onPressed: () { submit(); }),
              SizedBox(height: screenHeight * .05),
              NavigationLink(text: 'Iniciar Sesión', screen: LoginScreen())
            ],
          ),
        ),
      ),
    );
  }
}
