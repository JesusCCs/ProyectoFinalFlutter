import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/_models/gimnasio.dart';
import 'package:mobile_app/_services/gimnasio_service.dart';

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
            return SpinKitRipple(
              color: Colors.deepOrange,
              size: 300.0,
            );
          return Container(
            child: Text(item.nombre),
          );
        },
      ),
    );
  }
}