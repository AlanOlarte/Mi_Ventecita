import 'package:flutter/material.dart';
import 'package:producto_venta/model/detalle_model.dart';
import 'package:producto_venta/model/venta_model.dart';
import 'package:producto_venta/model/venta_productos.dart';

import '../db_provider.dart';

class DetalleVentaProvider extends ChangeNotifier {

  List<VentaModel> venta = [];
  List<DetalleModel> detalle = [];
  List<VentaProductosModel> ventaProducto = [];

  Future<VentaModel> newDetalleVenta(String fecha, double importe, double pago, double cambio, Map<int, int> lista) async {
    final newVenta = new VentaModel(
      fecha: fecha,
      importe: importe,
      pago: pago,
      cambio: cambio
    );
    final id = await DBProvider.db.newVenta(newVenta);
    newVenta.id_ventas = id;
    this.venta.add(newVenta);

    lista.forEach((key, value) async {
      final newDetalle = new DetalleModel(
          id_venta: id,
          id_producto: key,
          cantidad: value
      );
      await DBProvider.db.newDetalleVenta(newDetalle);
      this.detalle.add(newDetalle);
      notifyListeners();
    });
    await lista.clear();
    notifyListeners();
    return newVenta;
  }

  Future<VentaModel> cargarVentasByID(int id) async {
    final venta = DBProvider.db.getVentasById(id);
    return venta;
  }

  cargarVentas() async {
    final venta = await DBProvider.db.getVentas();
    this.venta = [...venta];
    notifyListeners();
  }

  DeleteVentas( int id ) async {
    await DBProvider.db.deleteVentas(id);
    this.cargarVentas();
  }

  Future<DetalleModel> newDetalle(int id_venta, int id_producto, int cantidad) async {
    final newDetalle = new DetalleModel(
      id_venta: id_venta,
      id_producto: id_producto,
      cantidad: cantidad,
    );
    await DBProvider.db.newDetalleVenta(newDetalle);
    this.detalle.add(newDetalle);
    notifyListeners();
    return newDetalle;
  }

  cargarDetalles() async {
    final detalle = await DBProvider.db.getTodosLosDetalles();
    this.detalle = [...detalle];
    notifyListeners();
  }

  Future<List<VentaProductosModel>> productos () async {
    final producto = await DBProvider.db.getVentaProductos();
    return producto;
  }

  cargarVentaProducto() async {
    final producto = await DBProvider.db.getVentaProductos();
    this.ventaProducto = [...producto];
    //notifyListeners();
  }
}