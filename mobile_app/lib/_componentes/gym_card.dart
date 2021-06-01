import 'package:flutter/material.dart';
import 'package:mobile_app/_models/gimnasio.dart';
import 'package:mobile_app/pantallas/detalles/details_screen.dart';

class GymCard extends StatelessWidget {
  final GimnasioList item;

  GymCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(item.nombre, style: TextStyle(fontSize: 18)),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Tarifa: ${item.tarifa} €/mes",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6), fontSize: 18),
              ),
            ),
          ),
          Image.network(item.logo),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              item.descripcion,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DetailsScreen(id: item.id)));
                    },
                    child: const Text('DETALLES'),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
