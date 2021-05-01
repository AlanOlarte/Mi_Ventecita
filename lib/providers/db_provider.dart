import 'dart:io';
import 'package:path/path.dart';
import 'package:producto_venta/model/venta_productos.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';

import 'package:producto_venta/model/productos_model.dart';
export 'package:producto_venta/model/productos_model.dart';

import 'package:producto_venta/model/detalle_model.dart';
export 'package:producto_venta/model/detalle_model.dart';

import 'package:producto_venta/model/venta_model.dart';
export 'package:producto_venta/model/venta_model.dart';

// Clase para crear base de datos SQLite en el dispositivo móvil
class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();
  String tableProducto = 'productos';
  String id_producto = 'id_producto';

  String tableVenta = 'ventas';
  String id_venta = 'id_ventas';

  String tableDetalle = 'detalleVenta';

  // Metodo para acceder a la base de datos
  Future<Database> get database async {

    // Si no hay base de datos, se creará y retornará
    if( _database != null) return _database;

    // en caso de haber base de datos creada, se retornará
    _database = await initDB();
    return _database;
  }

  // Metodo para la creacion de la base de datos SQLite
  Future<Database> initDB() async {

    // Obtenemos la direccion donde se almacena la aplicacion en el dispositivo
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    // Concatenamos la direccion del dispositivo con el nombre de la base de datos
    final path = join( documentDirectory.path, 'ProductosDB.db' );

    return await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('''
              create table productos(
                  id_producto INTEGER PRIMARY KEY,
                  nombre TEXT,
                  precio REAL,
                  descripcion TEXT,
                  image TEXT
              );
          ''');
          await db.execute('''
              create table ventas(
                  id_ventas INTEGER PRIMARY KEY,
                  fecha TEXT,                
                  importe REAL,
                  pago REAL,
                  cambio REAL
              );
          ''');
          await db.execute('''
              create table detalleVenta(
                  id_venta INTEGER,
                  id_producto INTEGER,
                  cantidad INTEGER,
                  CONSTRAINT fk_producto
                  FOREIGN KEY (id_producto)
                  REFERENCES productos(id_producto),
                  CONSTRAINT fk_venta
                  FOREIGN KEY (id_venta)
                  REFERENCES ventas(id_ventas)
              );
          ''');
        }
    );
  }


  // Metodos para la base de datos de Productos
  Future<int> newProducto( ProductoModel nuevoProducto ) async {
    final db = await database;
    final res = db.insert(tableProducto, nuevoProducto.toJson());
    return res;
  }

  Future<List<ProductoModel>> getProductos() async {

    final db  = await database;
    final res = await db.query(tableProducto);

    return res.isNotEmpty
        ? res.map( (s) => ProductoModel.fromJson(s) ).toList()
        : [];
  }

  Future<ProductoModel> getProductoById( int id ) async {

    final db  = await database;
    final res = await db.query(tableProducto, where: '$id_producto = ?', whereArgs: [id]);

    return res.isNotEmpty
        ? ProductoModel.fromJson(res.first)
        : null;
  }

  Future<int> updateProducto(ProductoModel producto) async {
    final db = await database;
    final res = db.update(tableProducto, producto.toJson(), where: '$id_producto = ?', whereArgs: [producto.id_producto]);
    return res;
  }

  Future<int> deleteProducto( int id ) async {
    final db = await database;
    final res = await db.delete(tableProducto, where: '$id_producto = ?', whereArgs: [id]);
    return res;
  }


  // Metodos para la base de datos de ventas
  Future<int> newVenta( VentaModel nuevaVenta ) async {
    final db = await database;
    final res = db.insert(tableVenta, nuevaVenta.toJson());
    return res;
  }

  Future<List<VentaModel>> getVentas() async {

    final db  = await database;
    final res = await db.query(tableVenta);

    return res.isNotEmpty
        ? res.map( (s) => VentaModel.fromJson(s) ).toList()
        : [];
  }

  Future<VentaModel> getVentasById( int id ) async {

    final db  = await database;
    final res = await db.query(tableVenta, where: '$id_venta = ?', whereArgs: [id]);

    return res.isNotEmpty
        ? VentaModel.fromJson(res.first)
        : null;
  }

  Future<int> updateVentas(VentaModel producto) async {
    final db = await database;
    final res = db.update(tableVenta, producto.toJson(), where: '$id_venta = ?', whereArgs: [producto.id_ventas]);
    return res;
  }

  Future<int> deleteVentas( int id ) async {
    final db = await database;
    final res = await db.delete(tableVenta, where: '$id_venta = ?', whereArgs: [id]);
    return res;
  }


  // Metodos para la base de datos de Detalle de ventas
  Future<int> newDetalleVenta( DetalleModel nuevoDetalle ) async {
    final db = await database;
    db.rawInsert('insert into detalleVenta(id_venta, id_producto, cantidad) VALUES (? ,? ,?);',
        [nuevoDetalle.id_venta, nuevoDetalle.id_producto, nuevoDetalle.cantidad]);
  }

  Future<List<DetalleModel>> getTodosLosDetalles() async {

    final db  = await database;

    final res = await db.query(tableDetalle);

    return res.isNotEmpty
        ? res.map( (s) => DetalleModel.fromJson(s) ).toList()
        : [];
  }

  Future<List<DetalleModel>> getDetalleVentasRaw() async {

    final db  = await database;
    final res = await db.rawQuery('''
        select dv.*  
        from detalleVenta as dv, productos as p, ventas as v 
        where v.id_ventas = dv.id_venta and p.id_producto=dv.id_producto;
    ''');

    return res.isNotEmpty
        ? res.map( (s) => DetalleModel.fromJson(s) ).toList()
        : [];
  }

  Future<DetalleModel> getDetalleVentasById( int id_venta, int id_producto ) async {

    final db  = await database;
    final res = await db.query(tableDetalle, where: '${this.id_venta} = ? and ${this.id_producto} = ?', whereArgs: [id_venta, id_producto]);

    return res.isNotEmpty
        ? DetalleModel.fromJson(res.first)
        : null;
  }

  Future<int> updateDetalleVentas(DetalleModel detalle) async {
    final db = await database;
    final res = db.update(tableVenta, detalle.toJson(), where: '${this.id_venta} = ? and ${this.id_producto} = ?', whereArgs: [detalle.id_venta, detalle.id_producto]);
    return res;
  }

  Future<int> deleteDetalleVentas( int id_venta, int id_producto ) async {
    final db = await database;
    final res = await db.delete(tableVenta, where: '${this.id_venta} = ? and ${this.id_producto} = ?', whereArgs: [id_venta, id_producto]);
    return res;
  }

  Future<List<VentaProductosModel>> getVentaProductos() async {

    final db  = await database;

    final res = await db.rawQuery('''
        select v.id_ventas as id_venta, p.nombre as nombre, p.precio as precio, dv.cantidad as cantidad
        from detalleVenta as dv, productos as p, ventas as v
        where dv.id_venta=v.id_ventas and p.id_producto=dv.id_producto;
    ''');

    return res.isNotEmpty
        ? res.map( (s) => VentaProductosModel.fromJson(s) ).toList()
        : [];
  }
}