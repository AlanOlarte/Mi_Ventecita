import 'package:flutter/material.dart';

import 'file:///C:/Users/xlxn_/Documents/Android_Studio/Productos_Ventas/producto_venta/lib/providers/venta/producto_precio.dart';

import 'package:provider/provider.dart';

class NumericKeypad extends StatefulWidget {

  @override
  _NumericKeypadState createState() => _NumericKeypadState();
}

class _NumericKeypadState extends State<NumericKeypad> {

  bool point = false;
  String result = '';

  @override
  Widget build(BuildContext context) {
    final precio = Provider.of<PrecioProvider>(context);
    result = '${precio.pago}';

    return Container(
      height: 300,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            var height = constraints.biggest.height / 4;

            return Table(
              border: TableBorder.all(
                color: Colors.grey,
                width: 1.0,
              ),
              children: [
                TableRow(children: [
                  _num("1", height, context),
                  _num("2", height, context),
                  _num("3", height, context),
                ]),
                TableRow(children: [
                  _num("4", height, context),
                  _num("5", height, context),
                  _num("6", height, context),
                ]),
                TableRow(children: [
                  _num("7", height, context),
                  _num("8", height, context),
                  _num("9", height, context),
                ]),
                TableRow(children: [
                  //_num("", height, context),
                  Container(),
                  _num("0", height, context),
                  GestureDetector(
                    onTap: () {
                      int pago = precio.pago.toInt() ~/ 10;
                      precio.pago = pago.toDouble();
                    },
                    child: Container(
                      height: height,
                      child: Center(
                        child: Icon(
                          Icons.backspace,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            );
          }),
    );
  }

  Widget _num(String text, double height, BuildContext context) {

    final precio = Provider.of<PrecioProvider>(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        precio.pago = precio.pago * 10 + double.parse(text);
      },
      child: Container(
        height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 40,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
