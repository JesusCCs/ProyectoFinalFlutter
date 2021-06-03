import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/_componentes/skip_button.dart';
import 'package:mobile_app/_componentes/video.dart';
import 'package:mobile_app/_models/anuncio.dart';
import 'package:mobile_app/_services/anuncio_service.dart';
import 'package:mobile_app/pantallas/listado/listado_screen.dart';

class AnuncioScreen extends StatefulWidget {
  @override
  _AnuncioScreenState createState() => _AnuncioScreenState();
}

class _AnuncioScreenState extends State<AnuncioScreen> {
  Anuncio? anuncio;
  bool anuncioVisto = false;

  Future<bool> getData() async {
    anuncio = await AnuncioService.getAnuncio();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: anuncioVisto
          ? ListadoScreen()
          : FutureBuilder<bool>(
              future: getData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: SpinKitCircle(color: Colors.deepOrange, size: 100.0),
                  );

                return anuncio == null
                    ? ListadoScreen()
                    : Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Stack(
                          children: getContent(screenWidth),
                        ),
                      );
              },
            ),
    );
  }

  List<Widget> getContent(screenWidth) {
    if (anuncio!.tipo == Anuncio.IMAGEN || anuncio!.tipo == Anuncio.GIF) {
      return <Widget>[
        Center(child: Image.network(anuncio!.ruta, width: screenWidth)),
        Positioned(
            bottom: 40,
            right: -4,
            child: SkipButton(onSkip: skip, waitInSeconds: 5))
      ];
    }

    return <Widget>[
      Video(recurso: anuncio!.ruta, onEnded: onEnded, onSkip: skip)
    ];
  }

  Future skip(bool notSkip) async {
    if (notSkip) return;

    await AnuncioService.anucioVisto(anuncio!.id);
    setState(() => this.anuncioVisto = true);
  }

  /// Si terminamos el vídeo, nos vamos a la pantalla principal
  onEnded() async {
    await AnuncioService.anucioVisto(anuncio!.id);
    setState(() => this.anuncioVisto = true);
  }
}
