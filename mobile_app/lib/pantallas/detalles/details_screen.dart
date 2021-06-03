import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/_componentes/loading.dart';
import 'package:mobile_app/_models/gimnasio.dart';
import 'package:mobile_app/_services/gimnasio_service.dart';
import 'package:mobile_app/_themes/app_text.dart';
import 'package:mobile_app/_themes/colors.dart';

class DetailsScreen extends StatefulWidget {
  final String id;

  DetailsScreen({required this.id});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late GimnasioDetails item;

  Future<bool> getData() async {
    item = await GimnasioService.getDetails(widget.id);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Loading();
          return Scaffold(
            backgroundColor: ThemeColors.darkBg,
            body: getBody(),
          );
        },
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: item.logo,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.45),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  AppTitle(item.nombre),
                  AppSubTitle(item.identificador),
                  SizedBox(height: 17),
                  AppSectionTitle("Tarifa"),
                  AppSectionDescription("${item.tarifa} €/mes"),
                  SizedBox(height: 17),
                  AppSectionTitle("Dirección"),
                  AppSectionDescription(item.direccion),
                  SizedBox(height: 17),
                  AppSectionTitle("Descripción"),
                  AppSectionDescription(item.descripcion),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
