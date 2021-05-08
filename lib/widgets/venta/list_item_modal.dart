import 'package:flutter/material.dart';

import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/detalle/list_detalle_venta.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/venta/list_producto_by_id.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/venta/producto_precio.dart';

import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/widgets/venta/numeric_keypad.dart';

import 'package:provider/provider.dart';

class ListaItems extends StatelessWidget {

  final ScrollController scrollController;
  ListaItems( this.scrollController );
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {

    final precioTotal = Provider.of<PrecioProvider>(context);
    final listaProducto = Provider.of<ListProductoById>(context);
    final detalleProvider = Provider.of<DetalleVentaProvider>(context);

    return ListView(
      controller: this.scrollController,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )
          ),
          width: double.infinity,
          height: 40.0,
          child: Center(
            child: Container(
              width: 40.0,
              height: 5.0,
              decoration: BoxDecoration(
                  color: Colors.grey,
                borderRadius: BorderRadius.circular(50.0)
              ),
            ),
          ),
        ),
        Center(
            child: _customText('Total: \$ ${precioTotal.precio}', 40.0)
        ),
        SizedBox(height: 20.0,),
        TextButton(
          child: _customText('Vender', 35.0),
          onPressed: (){
            final pago = (precioTotal.pago == 0.0)? precioTotal.precio : precioTotal.pago;
            if(listaProducto.myList.isNotEmpty) {
              detalleProvider.newDetalleVenta(
                  now.toString(),
                  precioTotal.precio,
                  pago,
                  precioTotal.cambio,
                  listaProducto.myList);
              precioTotal.precio = 0.0;
            }
            precioTotal.pago = 0.0;
            precioTotal.cambio = 0.0;
          },
        ),
        SizedBox(height: 20.0,),
        Center(
            child: _customText('Pago: \$ ${precioTotal.pago}', 40.0)
        ),
        SizedBox(height: 20.0,),
        Center(
            child: _customText('Cambio: \$ ${precioTotal.cambio}', 40.0)
        ),
        SizedBox(height: 20.0,),
        NumericKeypad()
      ],
    );
  }

  Widget _customText(String text, double size) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Text(text, style: TextStyle(fontSize: size),)
    );
  }
}