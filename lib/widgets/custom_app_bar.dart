import 'package:flutter/material.dart';

import 'package:producto_venta/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final double _prefferedHeight = 60.0;
  final double _textSize = 30.0;

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    switch( uiProvider.selectedMenuOpt ) {
      case 0:
        return _ventaAppBar();
      case 1:
        return _productoAppBar(context);
      case 2:
        return _detalleAppBar();
    //case 3:
    //  return CustomCalendar();
      default:
        return _ventaAppBar();
    }
  }

  Widget _ventaAppBar() {
    return SafeArea(
      child: Container(
        color: Colors.blue,
        height: _prefferedHeight,
        child: Center(child: Text('Ventas', style: TextStyle(fontSize: _textSize, color: Colors.white, fontWeight: FontWeight.w600))),
      ),
    );
  }

  Widget _productoAppBar(BuildContext context) {
    return SafeArea(
      child: Container(
        height: _prefferedHeight,
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 60.0),
            Center(child: Text('Productos', style: TextStyle(fontSize: _textSize, color: Colors.white, fontWeight: FontWeight.w600))),
            IconButton(
              icon: Icon(Icons.add_business),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, 'productAdd');
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _detalleAppBar() {
    return SafeArea(
      child: Container(
        color: Colors.blue,
        height: _prefferedHeight,
        child: Center(child: Text('Detalles', style: TextStyle(fontSize: _textSize, color: Colors.white, fontWeight: FontWeight.w600))),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}
 