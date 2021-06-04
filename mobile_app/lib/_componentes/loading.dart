import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// PAra mostrar cuando se está cargando algún recurso.
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: SpinKitCircle(color: Colors.deepOrange, size: 100.0),
    );
  }
}
