import 'package:flutter/material.dart';
import 'package:producto_venta/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    return BottomNavigationBar(
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.blue,
      currentIndex: uiProvider.selectedMenuOpt,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Venta',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_rounded),
          label: 'Productos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Detalles',
        ),
        //BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendario',),
      ],
    );
  }
}