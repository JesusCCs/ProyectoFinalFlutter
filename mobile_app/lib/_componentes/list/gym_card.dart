import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/_models/gimnasio.dart';
import 'package:mobile_app/pantallas/detalles/details_screen.dart';

/// Pequeña carta con diseño sencillo que muestra una imagen a la izquierda
/// y el texto con información relevante a la derecha
class GymCard extends StatelessWidget {
  final GimnasioList item;
  final String descriptionSearch;

  GymCard({required this.item, required this.descriptionSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailsScreen(id: item.id))),
        child: SizedBox(
          height: 125,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                  aspectRatio: 1.0,
                  child: CachedNetworkImage(
                    imageUrl: item.logo,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getBody(),
                      getFooter(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.nombre,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 2.0)),
          item.description(descriptionSearch),
        ],
      ),
    );
  }

  Widget getFooter() {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "Tarifa: ${item.tarifa} €/mes",
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
          )
        ],
      ),
    );
  }
}
