import 'dart:convert';

DetalleModel detalleModelFromJson(String str) => DetalleModel.fromJson(json.decode(str));
String detalleModelToJson(DetalleModel data) => json.encode(data.toJson());

class DetalleModel {
  DetalleModel({
    this.id_venta,
    this.id_producto,
    this.cantidad,
    this.pago,
    this.cambio
  });

  int id_venta;
  int id_producto;
  int cantidad;
  double pago;
  double cambio;

  factory DetalleModel.fromJson(Map<String, dynamic> json) => DetalleModel(
    id_venta: json["id_venta"],
    id_producto: json["id_producto"],
    cantidad: json["cantidad"],
    pago: json["pago"],
    cambio: json["cambio"],
  );

  Map<String, dynamic> toJson() => {
    "id_venta": id_venta,
    "id_producto": id_producto,
    "cantidad": cantidad,
    "pago": pago,
    "cambio": cambio,
  };
}
