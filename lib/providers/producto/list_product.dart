import 'package:flutter/material.dart';

import '../db_provider.dart';

class ProductListProvider extends ChangeNotifier {

  List<ProductoModel> medicine = [];

  Future<ProductoModel> newProducto(String nombre, double precio, String descripcion, String image ) async {
    final newProducto = new ProductoModel(
      nombre: nombre,
      precio: precio,
      descripcion: descripcion,
      image: image
    );
    final id = await DBProvider.db.newProducto(newProducto);
    newProducto.id_producto = id;
    this.medicine.add(newProducto);
    notifyListeners();
    return newProducto;
  }

  Future<ProductoModel> cargarProductoByID(int id) async {
    final producto = DBProvider.db.getProductoById(id);
    return producto;
  }

  cargarProducto() async {
    final medicine = await DBProvider.db.getProductos();
    this.medicine = [...medicine];
    notifyListeners();
  }


  DeleteProducto( int id ) async {
    await DBProvider.db.deleteProducto(id);
    this.cargarProducto();
  }
}