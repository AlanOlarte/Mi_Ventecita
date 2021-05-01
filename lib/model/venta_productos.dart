import 'dart:convert';

VentaProductosModel ventaProductosModelFromJson(String str) => VentaProductosModel.fromJson(json.decode(str));
String ventaProductosModelToJson(VentaProductosModel data) => json.encode(data.toJson());

class VentaProductosModel {
  VentaProductosModel({
    this.id_venta,
    this.nombre,
    this.precio,
    this.cantidad,
  });

  int id_venta;
  String nombre;
  double precio;
  int cantidad;

  factory VentaProductosModel.fromJson(Map<String, dynamic> json) => VentaProductosModel(
    id_venta: json["id_venta"],
    nombre: json["nombre"],
    precio: json["precio"],
    cantidad: json["cantidad"],
  );

  Map<String, dynamic> toJson() => {
    "id_venta": id_venta,
    "nombre": nombre,
    "precio": precio,
    "cantidad": cantidad,
  };
}
