import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/_componentes/skip_button.dart';
import 'package:video_player/video_player.dart';

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
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    print("RECURSO-------");
    print(widget.recurso);

    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Reproducimos el vídeo una vez está cargado
      _controller.play();

      // Controlamos el momento en el que se termina de ver para llamar a la
      // acción que nos dan por parámetro
      _controller.addListener(() {
        print(_controller.value.position);
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
            return Container(
              decoration: BoxDecoration(color: Colors.white),
              child: SpinKitCircle(color: Colors.deepOrange, size: 100.0),
            );
          }
        },
      ),
    );
  }
}
