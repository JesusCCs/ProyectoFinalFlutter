import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mobile_app/_componentes/form/form_button.dart';
import 'package:mobile_app/_componentes/form/navigation_link.dart';
import 'package:mobile_app/_services/auth_service.dart';
import 'package:mobile_app/pantallas/auth/login_screen.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  submit() async {
    final isValid = _formKey.currentState!.saveAndValidate();

    if (!isValid) return;

    final email = _formKey.currentState!.fields['email']!.value;

    await AuthService.forgot(email);

    FocusScope.of(context).unfocus();

    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: "¡Todo listo!",
      text:
          "Si has escrito bien tu email, recibirás un correo con los pasos a seguir para recuperar tu cuenta",
    );
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
              FormBuilderTextField(
                  name: 'email',
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(context),
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 3)
                  ])),
              SizedBox(height: screenHeight * .025),
              SizedBox(height: screenHeight * .075),
              FormButton(text: "Recuperar", onPressed: () => submit()),
              SizedBox(height: screenHeight * .05),
              NavigationLink(text: 'Iniciar Sesión', screen: LoginScreen())
            ],
          ),
        ),
      ),
    );
  }
}
