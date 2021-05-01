import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/pages/detalle/detalle_page.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/pages/producto/productos_page.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/pages/venta/venta_producto.dart';

import 'package:producto_venta/providers/ui_provider.dart';
import 'package:producto_venta/widgets/custom_navigatorbar.dart';

import 'package:provider/provider.dart';

import 'calendar.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_business),
            onPressed: () {
              Navigator.pushNamed(context, 'productAdd');
            },
          )
        ],
      ),
      body: _HomePageBody(),
        bottomNavigationBar: CustomNavigationBar(),
      backgroundColor: Colors.grey[200],
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    switch( uiProvider.selectedMenuOpt ) {
      case 0:
        return VentaProductos();
      case 1:
        return ProductosPages();
      case 2:
        return DetallesPage();
      //case 3:
      //  return CustomCalendar();
      default:
        return VentaProductos();
    }
  }
}