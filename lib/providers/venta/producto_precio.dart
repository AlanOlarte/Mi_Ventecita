import 'package:flutter/material.dart';

class PrecioProvider with ChangeNotifier{

  double _precio = 0.0;
  double _pago = 0.0;
  double _cambio = 0.0;

  double get precio => _precio;

  set precio(double value) {
    _precio = value;
    notifyListeners();
  }

  double get cambio{
    (_pago == 0.0)? _cambio=0.0 : _cambio =  _pago - _precio;
    return _cambio;
  }

  set cambio(double value) {
    _cambio = value;
    notifyListeners();
  }

  double get pago => _pago;

  set pago(double value) {
    _pago = value;
    notifyListeners();
  }
}