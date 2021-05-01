import 'package:flutter/material.dart';
import 'dart:io';

import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/producto/image_file.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/producto/list_product.dart';
import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/widgets/producto/camera_screen.dart';

import 'package:provider/provider.dart';

class ProductAdd extends StatelessWidget {

  String _nombre;
  double _cantidad;
  String _descripcion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Productos'),
      ),
      body:  Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
        ),
        child: ListView(
          children: [
            _cargarImage( context ),
            _inputNombre(),
            _inputCantidad(),
            _inputDescripcion(),
            _button(context)
          ],
        ),
      ),
    );
  }

  Widget _cargarImage( BuildContext context ) {
    final image = Provider.of<ImageFileProvider>(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15.0, bottom: 5.0, right: 5.0, left: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          (image.imageFile==null)?Image(width: 120, image: AssetImage('assets/image/image_icon.png'), color: Colors.grey):Image.file(File(image.imageFile), height: 150,),
          IconButton(
            icon: Icon(Icons.add_a_photo),
            iconSize: 40.0,
            color: Colors.blue,
            onPressed: () async {
              //final ImagePicker _picker = ImagePicker();
              //PickedFile _pickerFile = await _picker.getImage(source: ImageSource.camera);
              image.imageFile = await Navigator.of(context).push( MaterialPageRoute( builder: (context) => CameraScreen()));
            },
            //label: Text('Tomar Foto'),
            //style: ElevatedButton.styleFrom(elevation: 0, padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _inputNombre() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: TextField(
        //autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Nombre del producto',
          labelText: 'Producto:',
        ),
        onChanged: (valor) {
          _nombre = valor;
        },
      ),
    );
  }

  Widget _inputCantidad() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: TextField(
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Precio del producto',
          labelText: 'Precio:',
        ),
        onChanged: (valor) {
          _cantidad = double.parse(valor);
        },
      ),
    );
  }

  Widget _inputDescripcion() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: TextField(
        //autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Descripción del producto',
          labelText: 'Descripción:',
        ),
        onChanged: (valor) {
          _descripcion = valor;
        },
      ),
    );
  }

  Widget _button( BuildContext context ) {
    final image = Provider.of<ImageFileProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ElevatedButton.icon(
        onPressed: () async{
          final productos = Provider.of<ProductListProvider>(context, listen: false);
          productos.newProducto(_nombre, _cantidad, _descripcion, image.imageFile);
          productos.cargarProducto();
          image.imageFile = null;
          Navigator.pop(context);
        },
        label: Text('Guardar'),
        icon: Icon(Icons.save),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 10),
            textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}
