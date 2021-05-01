import 'package:flutter/material.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/producto/list_product.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/widgets/producto/product_card_view.dart';
import 'package:provider/provider.dart';

class ProductosPages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productoListProvider = Provider.of<ProductListProvider>(context);
    final productos = productoListProvider.medicine;

    productoListProvider.cargarProducto();

    return Container(
      color: Colors.grey[200].withOpacity(0),
      child: ListView.builder(
          itemCount: productos.length,
          itemBuilder: ( _, i ) => Dismissible(
            key: UniqueKey(),
            resizeDuration: Duration(milliseconds: 550),
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.only(right: 20),
              color: Colors.red,
              alignment: AlignmentDirectional.centerEnd,
              child: Icon(Icons.delete),
            ),
            onDismissed: (DismissDirection direction) {
              Provider.of<ProductListProvider>(context, listen: false).DeleteProducto(productos[i].id_producto);
            },
            child: Container(
              margin: EdgeInsets.only(top: 7.5, bottom: 7.5, left: 15.0, right: 15.0),
              child: ProductCardView(
                nombre: productos[i].nombre,
                precio: productos[i].precio.toString(),
                descripcion: productos[i].descripcion,
                image: productos[i].image,
              ),
            ),
          )
      ),
    );
  }
}