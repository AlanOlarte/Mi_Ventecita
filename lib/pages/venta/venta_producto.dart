import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/widgets/venta/bottom_modal.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/widgets/venta/product_card.dart';

import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/producto/list_product.dart';

import 'package:provider/provider.dart';

class VentaProductos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final productListProvider = Provider.of<ProductListProvider>(context);

    final producto = productListProvider.medicine;
    productListProvider.cargarProducto();
    return Stack(
      children: [
        // Expanded ayuda a expandir el widget
        Container(
            color: Colors.grey[200],
            height: MediaQuery.of(context).size.height * 0.65,
            padding: EdgeInsets.only(bottom: 30.0, left: 15.0, right: 15.0),
            // Uso de tabla para mostar card
            child: GridView.builder(
              itemCount: producto.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0
              ),
              itemBuilder: (BuildContext context, int index) {
                // Gidget de Card Personalizado
                return Container(
                  //padding: EdgeInsets.only(top: 15.0, bottom: 30.0),
                  child: ProductCard(
                    nombre: producto[index].nombre, precio: producto[index].precio, image: producto[index].image, id: producto[index].id_producto),
                );
              },
            )
        ),
        BottomModal()
      ],
    );
  }
}
