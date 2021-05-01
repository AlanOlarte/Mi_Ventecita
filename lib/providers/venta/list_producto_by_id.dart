import 'package:flutter/material.dart';

class ListProductoById with ChangeNotifier {

  Map<int, int> _myList = new Map();

  Map<int, int> get myList => _myList;

  myListAdd(int id, int valor) {
    _myList.addAll({id:valor});
    notifyListeners();
  }

  myListUpdate(int id, int valor) {
    _myList.update(id, (value) => valor);
    notifyListeners();
  }

  myListDelete(int id) {
    _myList.remove(id);
    notifyListeners();
  }

  myListClear() {
    _myList.clear();
    notifyListeners();
  }
}