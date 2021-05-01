import 'package:flutter/material.dart';
import 'dart:io';

class ProductCardView extends StatelessWidget {

  String nombre;
  String precio;
  String descripcion;
  String image;

  ProductCardView({
    this.nombre,
    this.precio,
    this.descripcion,
    this.image
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 175.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
        boxShadow: [
          // Sombra arriba
          BoxShadow(
              blurRadius: 0.5,
              color: Colors.grey[300],
              offset: Offset(0,-1.0)
          ),
          // Sombra abajo
          BoxShadow(
              blurRadius: 1.0,
              color: Colors.grey[400],
              offset: Offset(0,2.0)
          ),
          // Sombra derecha
          BoxShadow(
              blurRadius: 0.5,
              color: Colors.grey[300],
              offset: Offset(-1.0,0)
          ),
          // Sombra izquierda
          BoxShadow(
              blurRadius: 1.0,
              color: Colors.grey[400],
              offset: Offset(2.0,0)
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            width: 100.0,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: (image != null || image == '')? Image.file(File(image)).image : AssetImage('assets/image/image_icon.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20.0)
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  top: 15.0,
                  right: 25.0,
                  bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((nombre != null || nombre == '')? nombre : '', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                      Text((precio != null || precio == '')? '\$$precio' : '', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),)
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text((descripcion != null || descripcion == '')? descripcion : '', style: TextStyle(fontSize: 15.0),)
                ],
              ),
            ),
          )
        ],
      ),
    );;
  }
}