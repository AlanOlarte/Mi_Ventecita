import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));
String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  ProductoModel({
    this.id_producto,
    this.nombre,
    this.precio,
    this.descripcion,
    this.image
  });

  int id_producto;
  String nombre;
  double precio;
  String descripcion;
  String image;

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
    id_producto: json["id_producto"],
    nombre: json["nombre"],
    precio: json["precio"],
    descripcion: json["descripcion"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id_producto": id_producto,
    "nombre": nombre,
    "precio": precio,
    "descripcion": descripcion,
    "image": image,
  };
}
