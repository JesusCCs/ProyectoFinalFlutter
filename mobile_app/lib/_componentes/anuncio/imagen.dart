import 'package:flutter/material.dart';
import 'package:mobile_app/_componentes/anuncio/skip_button.dart';

import '../loading.dart';

/// Muestra una imagen a partir de una URL. Además, contiene el botón de saltar
/// anuncion (SkipButton). Esto es necesario tenerlo a la misma vez en un solo
/// componente porque hay que sincronizar la carga de la imagen con el renderizado
/// del botón. Si se hiciese de otra manera, el botón comenzaría la cuenta atrás
/// antes de que la imagen estuviese completamente visible y quedaría extraño
class Imagen extends StatefulWidget {
  final String recurso;
  final double screenWidth;
  final onSkip;

  const Imagen({required this.recurso, required this.onSkip, required this.screenWidth});

  @override
  _ImagenState createState() => _ImagenState();
}

class _ImagenState extends State<Imagen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(widget.recurso,
        width: widget.screenWidth,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return Stack(
            children: [
              Center(
                child: child,
              ),
              Positioned(
                  bottom: 40,
                  right: -4,
                  child: SkipButton(onSkip: widget.onSkip, waitInSeconds: 5))
            ],
          );

          return Loading();
        },
      ),
    );
  }
}
