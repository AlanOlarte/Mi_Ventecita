import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/detalle/list_detalle_venta.dart';

import 'package:provider/provider.dart';

class DetallesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: _listaDetalle(context)
        )
    );
  }

  Widget _listaDetalle(BuildContext context) {
    final detalleProvider = Provider.of<DetalleVentaProvider>(context);
    detalleProvider.cargarVentas();
    detalleProvider.cargarDetalles();
    final venta = detalleProvider.venta;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      color: Colors.grey[200],
      child: ListView.builder(
          itemCount: venta.length,
          itemBuilder: (_, i) => Container(
                child: Container(
                  height: 200,
                  margin: EdgeInsets.all(10.0),
                  //margin: EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 10.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Fecha: ${DateFormat.yMMMd().format(DateTime.parse(venta[i].fecha)).toString()}',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Hora: ${DateFormat.jm().format(DateTime.parse(venta[i].fecha)).toString()}',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text('Producto',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500))),
                            Expanded(
                                flex: 1,
                                child: Text('Cantidad',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500))),
                            Expanded(
                                flex: 1,
                                child: Text('Presio',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500))),
                            Expanded(
                                flex: 1,
                                child: Text('Total',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500))),
                          ],
                        ),
                      ),
                      Expanded(
                          child: listProductos(context, venta[i].id_ventas)),
                      Container(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Importe: ${venta[i].importe}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500)),
                              Text('Cobró: ${venta[i].pago}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500)),
                              Text('Cambio: ${venta[i].cambio}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500))
                            ],
                          )),
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: [
                        // Sombra arriba
                        BoxShadow(
                            blurRadius: 0.5,
                            color: Colors.grey[300],
                            offset: Offset(0, -1.0)),
                        // Sombra abajo
                        BoxShadow(
                            blurRadius: 1.0,
                            color: Colors.grey[400],
                            offset: Offset(0, 2.0)),
                        // Sombra derecha
                        BoxShadow(
                            blurRadius: 0.5,
                            color: Colors.grey[300],
                            offset: Offset(-1.0, 0)),
                        // Sombra izquierda
                        BoxShadow(
                            blurRadius: 1.0,
                            color: Colors.grey[400],
                            offset: Offset(2.0, 0))
                      ]),
                ),
              )),
    );
  }

  Widget listProductos(BuildContext context, int id) {
    final List<Widget> opciones = [];

    final detalleProvider = Provider.of<DetalleVentaProvider>(context);
    detalleProvider.cargarVentaProducto();

    final detalle = detalleProvider.ventaProducto;

    detalle.forEach((element) {
      if (element.id_venta == id) {
        final total = element.precio * element.cantidad;
        final widgetTemp = Container(
          padding: EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${element.nombre}',
                        textAlign: TextAlign.start,
                      ))),
              Expanded(
                  flex: 1,
                  child: Text(
                    '${element.cantidad}',
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    '${element.precio}',
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    '$total',
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        );
        opciones..add(widgetTemp);
      }
    });

    return Container(
      color: Colors.white70,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: opciones,
      ),
    );
  }
}
