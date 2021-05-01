import 'package:flutter/cupertino.dart';
import 'package:producto_venta/pages/homepage.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/pages/producto/product_add.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/'     : (BuildContext context) => HomePage(),
    'productAdd'     : (BuildContext context) => ProductAdd(),
  };
}