import 'package:flutter/material.dart';
import 'package:mobile_app/_models/gimnasio.dart';
import 'package:mobile_app/_themes/colors.dart';

class GymCard extends StatelessWidget {
  GimnasioList item;

  GymCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Stack(
            children: [
              Ink.image(
                image: NetworkImage(item.logo),
                colorFilter: ColorFilters.greyscale,
                height: 240,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Text(
                  item.nombre,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16).copyWith(bottom: 0),
            child: Text(item.descripcion, style: TextStyle(fontSize: 16)),
          ),
          ElevatedButton(onPressed: () => {}, child: Text('Botón'))
        ],
      ),
    );
  }
}
