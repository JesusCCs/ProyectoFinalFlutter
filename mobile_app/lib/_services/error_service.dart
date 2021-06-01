import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

abstract class ErrorService {

  static String? generalError;
  static dynamic dynamicErrors;

  static FutureOr<Response> dio(DioError e) {

    if (e.response == null) {
      generalError = "Error al intentar conectarse al servidor";
      return new Response(requestOptions: new RequestOptions(path: ''));
    }

    if (e.response!.statusCode == 500) {
      generalError = 'Error interno del servidor';
      return e.response!;
    }

    if (e.response!.statusCode == 400) {
      dynamicErrors = e.response!.data["errors"];
    }

    return e.response!;
  }

  static clear() {
    generalError = null;
    dynamicErrors = null;
  }

  static dynamic showGeneralAndGetDynamic(BuildContext context, GlobalKey<FormBuilderState> form) {

    if (generalError != null) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Error",
          text: generalError
      );

      return null;
    }

    List<String?> errors = List<String?>.filled(form.currentState!.fields.length, null);

    int i = 0;
    form.currentState!.fields.forEach((key, value) {
      errors[i] = dynamicErrors[key] != null ? (dynamicErrors[key] as List<dynamic>).first : null;
      i++;
    });

    return errors;
  }
}