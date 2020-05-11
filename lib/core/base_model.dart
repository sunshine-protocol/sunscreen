import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get isBusy => _busy;

  void busy() {
    _busy = true;
    notifyListeners();
  }

  void idle() {
    _busy = false;
    notifyListeners();
  }
}
