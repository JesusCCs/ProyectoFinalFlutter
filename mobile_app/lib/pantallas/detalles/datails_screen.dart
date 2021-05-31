import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/_models/gimnasio.dart';
import 'package:mobile_app/_services/gimnasio_service.dart';

class DatailsScreen extends StatefulWidget {
  final String id;

  DatailsScreen({required this.id});

  @override
  _DatailsScreenState createState() => _DatailsScreenState();
}

class _DatailsScreenState extends State<DatailsScreen> {
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