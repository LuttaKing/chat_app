import 'package:flutter/material.dart';

class MainNotifier extends ChangeNotifier {
  String? email = '';
  String? uid = '';

  void changeEmailr(String? pageNumber) {
    email = pageNumber;
    notifyListeners();
  }

   void changeuid(String? p) {
   uid = p;
    notifyListeners();
  }
}