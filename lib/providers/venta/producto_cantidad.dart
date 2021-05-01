import 'package:flutter/material.dart';

class CantidadProvider with ChangeNotifier{
  int _cantidad = 0;

  int get cantidad => _cantidad;

  set cantidad(int value) {
    _cantidad = value;
    notifyListeners();
  }
}