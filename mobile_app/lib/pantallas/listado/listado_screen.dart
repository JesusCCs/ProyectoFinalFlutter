import 'package:flutter/material.dart';
import 'package:mobile_app/_componentes/list/gym_card.dart';
import 'package:mobile_app/_componentes/list/search_bar.dart';
import 'package:mobile_app/_models/gimnasio.dart';
import 'package:mobile_app/_services/error_service.dart';
import 'package:mobile_app/_services/gimnasio_service.dart';

class ListadoScreen extends StatefulWidget {
  @override
  _ListadoScreenState createState() => _ListadoScreenState();
}

class _ListadoScreenState extends State<ListadoScreen> {

  List<GimnasioList>? list;
  List<GimnasioList>? originalList;

  String search = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    final list = await GimnasioService.getList();

    if (list == null) {
      ErrorService.showGeneralAndGetDynamic(context);
      return;
    }
    originalList = List.from(list);
    setState(() => this.list = list);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Sweat"),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              getSearchBar(),
              Expanded(
                child: ListView.builder(
                    itemCount: list == null ? 0 : list!.length,
                    itemBuilder: (context, index) {
                      if (list == null) return Container();
                      return GymCard(item: list![index]);
                    }),
              )
            ],
          )),
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

    final listaFiltrada = this.originalList!.where((gimnasio) {
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
