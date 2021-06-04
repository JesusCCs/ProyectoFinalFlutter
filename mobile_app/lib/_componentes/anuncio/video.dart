import 'package:flutter/material.dart';
import 'package:mobile_app/_componentes/anuncio/skip_button.dart';
import 'package:video_player/video_player.dart';

import '../loading.dart';

/// Se muestra un video a partir de una URL dada (recurso). Contiene también
/// el objeto de SkipButton para sincronizar el renderizado de éste con la
/// carga del vídeo.
///
/// También hace uso de una función que se debe pasar por parámetro que es onEnded
/// que sirve para realizar la acción que se ejecutará cuando finalice el video
class Video extends StatefulWidget {
  final String recurso;
  final onEnded;
  final onSkip;

  const Video(
      {required this.recurso, required this.onEnded, required this.onSkip});

  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.recurso);
    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Reproducimos el vídeo una vez está cargado
      _controller.play();

      // Controlamos el momento en el que se termina de ver para llamar a la
      // acción que nos dan por parámetro
      _controller.addListener(() {
        if (_controller.value.position == _controller.value.duration) {
          widget.onEnded();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(children: <Widget>[
              Center(
                  child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )),
              Positioned(
                  bottom: 40,
                  right: -4,
                  child: SkipButton(onSkip: widget.onSkip, waitInSeconds: 5))
            ]);
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
