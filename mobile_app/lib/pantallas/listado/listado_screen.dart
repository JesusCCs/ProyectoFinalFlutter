import 'package:flutter/material.dart';
import 'package:mobile_app/_componentes/list/gym_card.dart';
import 'package:mobile_app/_componentes/loading.dart';
import 'package:mobile_app/_models/gimnasio.dart';
import 'package:mobile_app/_services/error_service.dart';
import 'package:mobile_app/_services/gimnasio_service.dart';
import 'package:mobile_app/_themes/colors.dart';

class ListadoScreen extends StatefulWidget {
  @override
  _ListadoScreenState createState() => _ListadoScreenState();
}

class _ListadoScreenState extends State<ListadoScreen> {
  /// Se tienen dos listas. Una de ellas (list) es que se muestra
  /// y el resultado de aplicar los filtros. La otra (originalList) es la
  /// que tiene los datos que se trajeron incialmente del servidor y a la
  /// que se aplican los filtros para dar lugar a list.

  List<GimnasioList>? list;
  List<GimnasioList>? originalList;

  /// Se controlan las búsquedas de los filtros

  final controlName = TextEditingController();
  final controlDescription = TextEditingController();

  String name = '';
  String description = '';
  double price = 0;

  searchGym(String name, {String description = '', var price = 0}) {
    if (this.list == null) return;

    final listaFiltrada = this.originalList!.where((gimnasio) {
      final nombre = gimnasio.nombre.toLowerCase();
      final searchToLower = name.toLowerCase();

      final descripcion = gimnasio.descripcion.toLowerCase();
      final descriptionToLower = description.toLowerCase();

      return nombre.contains(searchToLower) &&
          descripcion.contains(descriptionToLower) &&
          gimnasio.tarifa >= price;
    }).toList();

    setState(() {
      this.name = name;
      this.description = description;
      this.price =  price;
      this.list = listaFiltrada;
    });
  }

  /// Se controla la muestra u ocultación de los filtros

  var show = false;

  Widget icon = Icon(Icons.list);

  toggleFilters(toggle) {
    setState(() => {
          this.show = toggle,
          icon = show ? Icon(Icons.unfold_less) : Icon(Icons.list)
        });
  }

  /// Se inicia el estado de la pantalla, donde se manda recuperar la lista

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

  /// Finalmente, se contruye la vista. Como en el resto de la aplicación,
  /// se construyen funciones soporte para encapsular a los componentes

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Sweat"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              toggleFilters(!show);
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              child: icon,
            ),
          ),
          body: Column(
            children: <Widget>[
              getSearchBar(),
              Expanded(
                child: ListView.builder(
                    itemCount: list == null ? 0 : list!.length,
                    itemBuilder: (context, index) {
                      if (list == null) return Loading();
                      return GymCard(item: list![index], descriptionSearch: this.description);
                    }),
              )
            ],
          )),
    );
  }

  Widget getSearchBar() {
    return Column(
      children: [
        getNameSearch(),
        show ? getDescriptionSearch() : Container(),
        show ? getPriceRange() : Container(),
      ],
    );
  }

  getNameSearch() {
    final styleActive = TextStyle(color: ThemeColors.textHighlighted);
    final styleHint = TextStyle(color: ThemeColors.darkBgWithOpacity);
    final style = name.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: style.color!),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controlName,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: name.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controlName.clear();
                    searchGym('', description: controlName.text, price: 0);
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: 'Nombre del gimnasio',
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: (search) =>
            searchGym(search, description: description, price: price),
      ),
    );
  }

  getDescriptionSearch() {
    final styleActive = TextStyle(color: ThemeColors.textHighlighted);
    final styleHint = TextStyle(color: ThemeColors.darkBgWithOpacity);
    final style = description.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: style.color!),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controlDescription,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: description.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controlDescription.clear();
                    searchGym(controlName.text, price: 0);
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: 'Palabras claves de la descripción',
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: (description) =>
            searchGym(name, description: description, price: price),
      ),
    );
  }

  getPriceRange() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 7, 0, 0),
      child: Slider(
        value: price,
        min: 0,
        max: 70,
        divisions: 70,
        label: 'Tarifa desde ${price.round().toString()} €',
        onChanged: (double value) {
          searchGym(controlName.text, description: description, price: value);
        },
        activeColor: ThemeColors.textHighlighted,
        inactiveColor: ThemeColors.darkBgWithOpacity,
      )
    );
  }
}
