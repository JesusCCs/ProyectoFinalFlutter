import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/_componentes/gym_card.dart';
import 'package:mobile_app/_componentes/search_bar.dart';
import 'package:mobile_app/_models/gimnasio.dart';
import 'package:mobile_app/_services/gimnasio_service.dart';

class ListadoScreen extends StatefulWidget {
  @override
  _ListadoScreenState createState() => _ListadoScreenState();
}

class _ListadoScreenState extends State<ListadoScreen> {
  List<GimnasioList>? list = [];
  String search = '';

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

          return Scaffold(
              appBar: AppBar(
                title: Text("Sweat"),
                centerTitle: true,
              ),
              body: Column(
                children: <Widget>[
                  getSearchBar(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: list?.length,
                        itemBuilder: (context, index) {
                          if (list == null) return Text('ERROR');
                          return GymCard(item: list![index]);
                        }),
                  )
                ],
              ));
        },
      ),
    );
  }

  Widget getSearchBar() {
    return SearchBar(
      search: search,
      placeholder: 'Nombre del gimnasio',
      onChanged: searchGym,
    );
  }


  searchGym(String search) {

    if (this.list == null) return;

    final listaFiltrada = this.list!.where((gimnasio) {
      final nombre = gimnasio.nombre.toLowerCase();
      final searchToLower = search.toLowerCase();

      return nombre.contains(searchToLower);
    }).toList();

    setState(() {
      this.search = search;
      this.list = listaFiltrada;
    });
  }
}
