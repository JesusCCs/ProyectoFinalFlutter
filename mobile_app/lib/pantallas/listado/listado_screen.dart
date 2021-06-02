import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/_componentes/gym_card.dart';
import 'package:mobile_app/_models/gimnasio.dart';
import 'package:mobile_app/_services/gimnasio_service.dart';

class ListadoScreen extends StatefulWidget {
  @override
  _ListadoScreenState createState() => _ListadoScreenState();
}

class _ListadoScreenState extends State<ListadoScreen> {
  List<GimnasioList>? list;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getData() async {
    list = await GimnasioService.getList();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (context, snapshot) {
          print(snapshot);
          if (!snapshot.hasData)
            return SpinKitRipple(
              color: Colors.deepOrange,
              size: 300.0,
            );

          return ListView.builder(
              itemCount: list?.length,
              itemBuilder: (context, index) {
                if (list == null) return Text('ERROR');
                return GymCard(item: list![index]);
              });
        },
      ),
    );
  }
}
