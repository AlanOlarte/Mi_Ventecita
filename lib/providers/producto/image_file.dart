import 'package:flutter/material.dart';

class ImageFileProvider with ChangeNotifier{
  String _imageFile;

  String get imageFile => _imageFile;

  set imageFile(String value) {
    _imageFile = value;
    notifyListeners();
  }
}