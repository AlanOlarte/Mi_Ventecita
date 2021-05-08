import 'package:flutter/material.dart';
import 'dart:io';

import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/venta/producto_precio.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/venta/list_producto_by_id.dart';

import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {

  String nombre;
  double precio;
  String image;
  int id;

  ProductCard({
    @required this.nombre,
    @required this.precio,
    @required this.image,
    @required this.id
  });

  @override
  _ProductCardState createState() => _ProductCardState(nombre: nombre, precio: precio, image: image, id: id);
}

class _ProductCardState extends State<ProductCard> {

  String nombre;
  double precio;
  String image;
  int id;


  _ProductCardState({
    @required this.nombre,
    @required this.precio,
    @required this.image,
    @required this.id
});

@override
Widget build(BuildContext context) {

  final precioTotal = Provider.of<PrecioProvider>(context);
  final listaProducto = Provider.of<ListProductoById>(context);

  return Container(
      height: double.maxFinite,
      decoration: (image != '')?
      BoxDecoration(borderRadius: BorderRadius.circular(40), image: DecorationImage(image: Image.file(File(image)).image, fit: BoxFit.cover,),):
      BoxDecoration(borderRadius: BorderRadius.circular(40), gradient: LinearGradient(colors: [Colors.blue[200], Colors.blue[900]], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.0,
            ),
            _CustomTextStyle(nombre, MediaQuery.of(context).size.width * 0.065, FontWeight.bold),
            _CustomTextStyle('\$ ${precio.toString()}', MediaQuery.of(context).size.width * 0.07, FontWeight.w400 ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10.0,
                ),
                _CustomCircularAvatar(
                  IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.add),
                      onPressed: () {
                        precioTotal.precio = precioTotal.precio + precio;
                        if(listaProducto.myList.isEmpty){
                          listaProducto.myListAdd(id, 1);
                        } else {
                          if(listaProducto.myList[id]==null){
                            listaProducto.myListAdd(id, 1);
                          } else {
                            int cantidad = listaProducto.myList[id] + 1;
                            listaProducto.myListUpdate(id, cantidad);
                          }
                        }
                      }
                  ),
                    Colors.green.withOpacity(0.5)
                ),
                _CustomCircularAvatar(
                  Center(child: Text('${(listaProducto.myList[id]==null)?0:listaProducto.myList[id]}', style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                  )
                  ),
                    Colors.black.withOpacity(0.3)
                ),
                _CustomCircularAvatar(
                  IconButton(
                      icon: Icon(Icons.remove, color: Colors.white),
                      disabledColor: Colors.lightBlueAccent,
                      onPressed: () {

                        if(listaProducto.myList[id] == 1) {
                          precioTotal.precio = precioTotal.precio - precio;
                          listaProducto.myListDelete(id);
                        } else {
                          if (precioTotal.precio > 0.0 && precio <= precioTotal.precio && listaProducto.myList[id] != null) {
                            precioTotal.precio = precioTotal.precio - precio;

                            int cantidad = listaProducto.myList[id] - 1;
                            listaProducto.myListUpdate(id, cantidad);
                          }
                        }
                      }
                  ),
                    Colors.red.withOpacity(0.5)
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      )
  );
}


Widget _CustomTextStyle( String texto, double size, FontWeight weight) {
  return FittedBox(
    fit: BoxFit.contain,
    child: Text(texto,
      style: TextStyle(
        fontSize: size,
        color: Colors.white,
        fontWeight: weight,
        shadows: [
          Shadow(
              blurRadius: 1.5,
              color: Colors.black54,
              offset: Offset(-2.0,0)
          ),
          Shadow(
              blurRadius: 1.5,
              color: Colors.black54,
              offset: Offset(0,-2.0)
          ),
          Shadow(
              blurRadius: 1.5,
              color: Colors.black54,
              offset: Offset(0,2.0)
          ),
          Shadow(
              blurRadius: 1.5,
              color: Colors.black54,
              offset: Offset(2.0,0)
          ),
        ],
      ),
    ),
  );
}

Widget _CustomCircularAvatar(Widget child, Color color) {
  return CircleAvatar(
    backgroundColor: color,
    child: child,
  );
}

}