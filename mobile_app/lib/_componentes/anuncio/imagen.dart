import 'package:flutter/material.dart';
import 'package:mobile_app/_componentes/anuncio/skip_button.dart';

import '../loading.dart';

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
