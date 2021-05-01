import 'dart:convert';

VentaModel ventaModelFromJson(String str) => VentaModel.fromJson(json.decode(str));
String ventaModelToJson(VentaModel data) => json.encode(data.toJson());

class VentaModel {
  VentaModel({
    this.id_ventas,
    this.fecha,
    this.importe,
    this.pago,
    this.cambio
  });

  int id_ventas;
  String fecha;
  double importe;
  double pago;
  double cambio;

  factory VentaModel.fromJson(Map<String, dynamic> json) => VentaModel(
    id_ventas : json["id_ventas"],
    fecha       : json["fecha"],
    importe     : json["importe"],
    pago     : json["pago"],
    cambio     : json["cambio"],
  );

  Map<String, dynamic> toJson() => {
    "id_ventas" : id_ventas,
    "fecha"       : fecha,
    "importe"     : importe,
    "pago"     : pago,
    "cambio"     : cambio,
  };
}
