import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/product.dart';


class CartBloc with ChangeNotifier {
  Map<String, int> _cart = {};
  Map<String , Product> _cartInfo = {};

  Map<String, int> get cart => _cart;
  Map<String, Product> get productInfo => _cartInfo;
 
  void addToCart(index,product) {
    if (_cart.containsKey(index)) {
      _cart[index] += 1;
    } else {
      _cart[index] = 1;
    }
    _cartInfo[index]=product;
    notifyListeners();
  }
  void subToCart(index,product) {
    if (_cart.containsKey(index)) {
      _cart[index] -= 1;
    } else {
      _cart[index] = 1;
    }
    _cartInfo[index]= product;
    notifyListeners();
  }

  void clear(index) {
    if (_cart.containsKey(index)) {
      _cart.remove(index);
      _cartInfo.remove(index);
      notifyListeners();
    }
  }
}
