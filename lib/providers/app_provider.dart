import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  bool _showCart = false;
  bool _showMenu = false;
  bool _isGdrpOptOut = false;

  bool get isShowCart => _showCart;
  void setShowCart(bool status) {
    _showCart = status;
    notifyListeners();
  }

  bool get isMenuOpen => _showMenu;
  void setMenuState(bool status) {
    _showMenu = status;
    notifyListeners();
  }

  bool get gdrpOptStatus => _isGdrpOptOut;
  void setGdrpOptStatu(bool status) {
    _isGdrpOptOut = status;
    notifyListeners();
  }
}
