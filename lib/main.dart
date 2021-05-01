import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/producto/image_file.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/detalle/list_detalle_venta.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/producto/list_product.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/venta/list_producto_by_id.dart';

import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/venta/producto_cantidad.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/venta/producto_precio.dart';
import 'package:producto_venta/providers/ui_provider.dart';

import 'package:producto_venta/rutes/routes.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new PrecioProvider()),
        ChangeNotifierProvider(create: (_) => new CantidadProvider()),
        ChangeNotifierProvider(create: (_) => new ProductListProvider()),
        ChangeNotifierProvider(create: (_) => new ImageFileProvider()),
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider(create: (_) => new ListProductoById()),
        ChangeNotifierProvider(create: (_) => new DetalleVentaProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mi Medicina',
          initialRoute: '/',
          routes: getApplicationRoutes()
      ),
    );
  }
}
